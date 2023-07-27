---
parent: Implementation issues
parent: Implementation
has_children: false
nav_order: 2
---

# Implementation Issues

## Scala Native, Rust and C interoperability

Among the possible solutions analyzed for developing an integration layer between Rust and Scala, it was decided to use Scala Native and leverage the languages' interoperability with C. The details of interoperability are defined in the documentation of both projects:

- [Rust](https://docs.rust-embedded.org/book/interoperability/index.html)
- [Scala Native](https://scala-native.org/en/stable/user/interop.html)

As the documentation states, interoperability has well-defined limits, and it is not possible to fully utilize the functionalities of both languages.

To make a Rust function interoperable with the C language, the following changes can be made:

```rust
// before
pub fn rust_function() {

}

// after
#[no_mangle]
pub extern "C" fn rust_function() {

}
```
The Rust compiler mangles symbol names differently than native code linkers expect. Therefore, any function that is exported from Rust to be used outside of Rust must be instructed not to be mangled by the compiler using `#[no_mangle]`. By default, functions written in Rust will use the Rust ABI, which is also not stabilized. However, when creating FFI APIs that are intended for external use, we need to instruct the compiler to use the system ABI by using extern "C".

It is important to note that you cannot use generics in Rust if your code needs to be interoperable with the C language.

The following Rust code:

```rust
#[no_mangle]
pub extern "C" fn local_sense<A: 'static>(&self, sensor_id: &SensorId) -> Option<&A> {
    self.context.local_sense::<A>(sensor_id)
}
```
gives the following warning:

![](/assets/images/functions-generic-over-types-must-be-mangled-warning.png)

This problem can be resolved by duplicating the functions for each data type that is compatible with both C and Rust, which unfortunately leads to code repetition.

Another challenge arises when dealing with data structures. To ensure compatibility with C, the `#[repr(C)]` directive must be applied to any data structure that needs to be made compatible. For example:

```rust
#[repr(C)]
pub struct I32RoundVMWrapper {
    pub(crate) vm: RoundVM,
}
```
If you use complex data structures, possibly defined in another crate, without the `#[repr(C)]` directive, it can lead to compatibility issues. Let's consider the following example:

```rust
#[no_mangle]
pub extern "C" fn new(context: Context) -> Self {
    Self {
        vm: RoundVM::new_empty(context)
    }
}
```
gives the following warning:

![](/assets/images/not-FFI-safe-warning.png)

It was also discovered that when using `#[no_mangle]`, it is not possible to have functions with the same name. If your project contains different modules, each with its own data structures, you cannot define functions with the same name in different modules. For example, if the function `new` is used to create instances of a `struct`:

```rust
    #[no_mangle]
    pub extern "C" fn new(context: Context, status: VMStatus, export_stack: Vec<Export>) -> Self {
        Self {
            context,
            status,
            export_stack,
            isolated: false,
        }
    }
```
gives the following error:

![](/assets/images/symbol-new-already-defined-error.png)

As for the interoperability of Scala Native with C data structures, this is supported for data structures of limited complexity:

```c
struct { int x, y; }*
```
Scala Native lacks binding capabilities for data structures more complex than the one listed above.

## Rust limitations emerged upon implementing language constructs

During the development of a minimal Field Calculus core in Rust, an unresolved issue surfaced that persists to this day.

The primary problem arises from Rust's inherent limitation with borrowing: it is not possible for mutable and immutable borrows of the same variable to coexist within the same scope. This limitation poses challenges when implementing the fundamental constructs of the language as they have been traditionally realized in Scala.

```rust
fn nbr<A: 'static + Clone>(&mut self, expr: impl Fn() -> A) -> A {
        let mut vm = &self.round_vm;
        vm.nest(
            Nbr(vm.index().clone()),
            vm.only_when_folding_on_self(),
            true,
            || {
                match vm.neighbor() {
                    Some(nbr) if nbr.clone() != vm.self_id() => {
                        vm.neighbor_val().unwrap_or(&expr()).clone()
                    }
                    _ => expr()
                }
            }
        )
    }
```

This code is invalid because it attempts to make a mutable borrow of round_vm during the call to nest(), while simultaneously having an immutable borrow inside the closure that implements the construct logic. In Rust, all references to variables outside the closure's scope are obtained through immutable borrowing.

Another issue encountered during the implementation of the core constructs in Rust was managing their dependency with the VM. As a solution, a choice was made to create a trait that encapsulates the definition of the constructs, along with a data structure that contains a RoundVM instance that must implement the trait.

```rust
pub trait Language {
    fn nbr<A: 'static + Clone>(&mut self, expr: impl Fn() -> A) -> A;
    ...
}

pub struct L {
    pub round_vm: RoundVM,
}

impl Language for L {
    ...
}
```

This choice ultimately poses a problem when attempting to compose two constructs, due to the aforementioned borrowing limitation:

```rust
let mut l = L::new();
// rep(0){x => nbr(x)+1}
let result = l.rep(||0, |a| l.nbr(||a) + 1);
```

In this code block, a mutable borrow is performed at l.rep(), while an immutable borrow is made inside the closure at l.nbr(), making the code invalid.

### Possible solutions

### Cells

To address the limitation to borrowing in Rust, the concept of a Cell was introduced. A Cell serves as a form of "internal mutability" and acts as a wrapper for a generic type that requires mutation. By wrapping the mutable variable with an immutable Cell, we can mutate the variable through the Cell interface itself. This allows us to have multiple immutable borrows of the Cell while still being able to access and modify its mutable state.

Here's an example of an nbr function that utilizes Cells to pass a reference to round_vm to the closure:

```rust
fn nbr<A: 'static + Clone>(&mut self, expr: impl Fn() -> A) -> A {
        let vm_cell = Cell::new(&mut self.round_vm);
        vm_cell.get().nest(
            Nbr(vm_cell.get().index().clone()),
            vm_cell.get().only_when_folding_on_self(),
            true,
            match vm_cell.get().neighbor() {
                Some(nbr) if nbr.clone() != vm_cell.get().self_id() => {
                    vm_cell.get().neighbor_val().unwrap_or(&expr()).clone()
                }
                _ => expr()
            }
        )
    }
```

This code resolves the issue of having mutable and immutable references to the same variable. However, note that the get() method requires the wrapped type to implement the Copy trait. Unfortunately, the Copy trait cannot be implemented by RoundVM because Export cannot implement it, as it contains references to Any.

### Create a macro to perform dependency injection in functions

The ability to perform dependency injection in functions through a macro such as:

```rust
    #[inject(RoundVM)]
    fn nbr<A: 'static + Clone>(&mut self, expr: impl Fn() -> A) -> A {
        ...
    }
```
would allow fundamental constructs to be defined as pure functions and not methods of an object, making it theoretically possible to write such code:

```rust
    let result = rep(||0, |a| nbr(||a) + 1);
```

as no problematic borrowing is performed.

It is important to note that currently, there doesn't appear to be a dependency injection framework in Rust capable of implementing the aforementioned code. However, it might be possible to explore potential solutions using Rust's macro system. Macros can provide a mechanism for code generation and abstraction, which could potentially be leveraged to address the dependency injection requirements in the code.

## Foldhood implementation issues

The Scala version of Foldhood is implemented as follows:

```scala
  override def foldhood[A](init: => A)(aggr: (A, A) => A)(expr: => A): A = {
    vm.nest(FoldHood(vm.index))(write = true) {// write export always for performance reason on nesting
      val nbrField = vm
        .alignedNeighbours()
        .map(id => vm.foldedEval(expr)(id).getOrElse(vm.locally(init)))
      vm.isolate(nbrField.fold(vm.locally(init))((x, y) => aggr(x, y)))
    }
  }
```

It's not possible to write  the same code in Rust, due to limitations of the language. The function below is the first implementation of the Foldhood in Rust:

```rust
pub fn foldhood<A: Copy + 'static>(mut vm: RoundVM, init: impl Fn() -> A, aggr: impl Fn(A, A) -> A, expr: impl Fn(RoundVM) -> (RoundVM, A)) -> (RoundVM, A) {
    vm.nest_in(FoldHood(vm.index().clone()));
    let nbrs = vm.aligned_neighbours().clone();
    let (mut vm_, preval) = expr(vm);
    let nbrfield =
        nbrs.iter()
            .map(|id| {
                vm_.folded_eval(|| preval, id.clone()).unwrap_or(init())
            });
    let val = nbrfield.fold(init(), |x, y| aggr(x, y));
    let res = vm_.nest_write(true, val);
    vm_.nest_out(true);
    (vm_, res)
}
```

The first thing to note is that the type of the `expr` parameter has been changed to `Fn(RoundVM) -> (RoundVM, A)`. This is due to the fact that each language construct takes a VM as a parameter, therefore the expression can't be a closure because otherwise no language construct could be called inside the expression.

The nest function has been split in three function: `nest_in` `nest_write` and `nest_out`.

In scala, the `nest_write` function for the foldhood contruct is the following:

```scala
exportData.get(status.path).getOrElse(exportData.put(status.path, expr))
```

Where the `expr` parameter is the following expression:

```scala
    val nbrField = vm
        .alignedNeighbours()
        .map(id => vm.foldedEval(expr)(id).getOrElse(vm.locally(init)))
    vm.isolate(nbrField.fold(vm.locally(init))((x, y) => aggr(x, y)))
```

The `expr` parameter is a closure that returns a value of type `A`. In Rust, the `expr` parameter is not a closure, but a function that takes a VM as a parameter and returns a tuple of type `(RoundVM, A`. This means that `expr` can be used as input parameter for the `nest_write` construct.

The first solution adopted is to pre-compute alle the value, aggregate them, and call the nest_write function with the result value of the aggregation.

By testing the foldhood, an issue has been found in the following lines of code:

```rust
let (mut vm_, preval) = expr(vm);
    let nbrfield =
        nbrs.iter()
            .map(|id| {
                vm_.folded_eval(|| preval, id.clone()).unwrap_or(init())
            });
```

The folded_eval computes the value of each device in the neighbor list. In Scala it is called by passing the expression, which is a closure, as a parameter. This can't be done in Rust as a borrowing error occurs. The solution adopted is to, again, pre compute the value of the expression and pass it as a parameter to the folded_eval function.
This is of course a problem, because each device will have the same value.

Another problem is that the `expr` requires a VM as a parameter and returns a new VM, so it's not possible to call it inside the map.

The solution adopted is to create a recursive function that for each device compute it's value and then call the function again with the new VM, until all the devices values have been computed.

This is the updated code:

```rust
let (vm_, local_init) = locally(vm, |vm_| (vm_, init()));
    let temp_vec: Vec<A> = Vec::new();
    let (mut vm__, nbrs_vec) = nbrs_computation(vm_, expr, temp_vec, nbrs, local_init);
    let val = nbrs_vec.iter().fold(local_init, |x, y| aggr(x, y.clone()));
```

Where the `nbrs_computation` function is the following:

```rust
fn nbrs_computation<A: Copy + 'static>(vm: RoundVM, expr: impl Fn(RoundVM) -> (RoundVM, A), mut tmp: Vec<A>, mut ids: Vec<i32>, init: A) -> (RoundVM, Vec<A>) {
    if ids.len() == 0 {
        return (vm, tmp);
    } else {
        let current_id = ids.pop();
        let (vm_, res, expr_) = folded_eval(vm, expr, current_id);
        tmp.push(res.unwrap_or(init).clone());
        nbrs_computation(vm_, expr_, tmp, ids, init)
    }
}
```

To enable this solution the `folded_eval` function has been modified to return the new VM and the new expression to be used in the next iteration of the recursive function.
This is the new `folded_eval` function:

```rust
fn folded_eval<A: Copy + 'static, F>(mut vm: RoundVM, expr: F, id: Option<i32>) -> (RoundVM, Option<A>, F)
    where
        F: Fn(RoundVM) -> (RoundVM, A),
{
    vm.status = vm.status.push();
    vm.status = vm.status.fold_into(id);
    let (mut vm_, res) = expr(vm);
    vm_.status = vm_.status.pop();
    (vm_, Some(res), expr)
}
```

By running the following test an error occured:

```rust
#[test]
fn foldhood() {
    // Export of device 2: Export(/ -> "1", FoldHood(0) -> "1", FoldHood(0) / Nbr(0) -> 4)
    let export_dev_2 = export!((path!(), 1), (path!(FoldHood(0)), 1), (path!(Nbr(0), FoldHood(0)), 4));
    // Export of device 4: Export(/ -> "3", FoldHood(0) -> "3")
    let export_dev_4 = export!((path!(), 3), (path!(FoldHood(0)), 3));
    let mut exports: HashMap<i32, Export> = HashMap::new();
    exports.insert(2, export_dev_2);
    exports.insert(4, export_dev_4);
    let context = Context::new(0, Default::default(), Default::default(), exports);
    // Program: foldhood(-5)(_ + _)(nbr(2))
    let program = |vm| foldhood(vm,
                                || -5,
                                | a, b| (a + b),
                                |vm1| nbr(vm1, |vm2| (vm2, 2)));
    let result = round(init_with_ctx(context), program);
    assert_eq!(-4, result.1);
    }
```

This is the error thrown:

```bash
called `Option::unwrap()` on a `None` value
```

This error is thrown inside the `Nbr()` construct. As can be seen in the test code, nbr is called inside the foldhood and is part of the expression carried around as `expr()` parameter.

The problem here is that one of the neighbors is not aligned and therefore, when Nbr tries to retrieve the value of the neighbor, it returns None. In Scala this error is catched with a `try-catch` construct, but in Rust this is not possible.

A possible solution is to change the `nbr` signature to return a `Result` (an existing Rust construct) which can be either be of type A or Error. Unfortunately, we ran out of hours to spend on the project and we couldn't implement this solution.
The tests that are failing due to this problems are left in the code base, but they are commented out.

To conclude, the foldhood construct has been implemented in Rust. It works as intended except in the case in which one of the neighbors is not aligned to the expression called inside the foldhood.
