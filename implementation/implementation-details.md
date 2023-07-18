---
title: Implementation details
parent: Implementation
has_children: false
nav_order: 1
---

# Implementation details

## Rust features

## Ownership & borrowing

```rust
pub fn neighbor(&self) -> &Option<i32> {
    &self.status.neighbour
}
```

## Function overload

```rust
pub fn new() -> Self {
    Self {
        slots: vec![],
    }
}

pub fn new(slots: Vec<Slot>) -> Self {
    let mut reversed_slots = slots;
    reversed_slots.reverse();
    Self {
        slots: reversed_slots,
    }
}
```

```rust
impl From<Vec<Slot>> for Path {
    fn from(slots: Vec<Slot>) -> Self {
        let mut reversed_slots = slots;
        reversed_slots.reverse();
        Self {
            slots: reversed_slots,
        }
    }
}

```

## Lifetimes

```rust
pub fn register_root<A: 'static + Copy>(&mut self, v: A) {
    self.export_data().put(Path::new(), || v);
}
```

## Smart pointers

```rust
pub struct Export {
    pub(crate) map: HashMap<Path, Box<dyn Any>>,
}
```

## Macros

```rust
#[macro_export]
macro_rules! path {
    ($($x:expr),*) => {{
        let mut temp_vec = Vec::new();
        $(
            temp_vec.push($x);
        )*
        Path { slots: temp_vec }
    }};
}
```
