# LIMITAZIONI DI RUST

Durante lo sviluppo di un core minimale del Field Calculus in Rust, è emersa una problematica ad ora non risolta.

Il problema principale è la limitazione by-design di Rust al borrowing: non è infatti possibile che coesistano borrow mutabili ed immutabili di una stessa variabile nello stesso scope. Questa limitazione risulta problematica nell'implementazione dei costrutti fondamentali del linguaggio così come sono stati realizzati ad oggi in Scala:

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

Questo codice risulta invalido poichè viene effettuato un borrow mutabile della round_vm in corrispondenza della chiamata a nest() ed uno immutabile all'interno della chiusura con l'implementazione della logica del costrutto, in quanto in Rust tutti i riferimenti a variabili esterne allo scope della chiusura sono ottenuti per borrowing immutabile.

Un altro problema riscontrato durante l'implementazione dei costrutti fondamentali in Rust è stato la gestione della loro dipendenza con la VM: infatti, la scelta è ricaduta sulla creazione di un trait che racchiude la definizione dei costrutti e di una struttura dati contenente una RoundVM che lo deve implementare:

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

Questa scelta risulta in ultima analisi problematica quando si vuole comporre due costrutti, a causa dell'insorgenza della limitazione al borrowing sopracitata:

```rust
    let mut l = L::new();
    // rep(0){x => nbr(x)+1}
    let result = l.rep(||0, |a| l.nbr(||a) + 1);
```
In questo blocco di codice viene effettuato un borrowing mutabile in corrispondenza di l.rep() ed uno immutabile nella chiusura in corrispondenza di l.nbr(), rendendo il codice invalido.

## POSSIBILI SOLUZIONI

### CELLE

### CREAZIONE DI UNA MACRO PER EFFETTUARE DEPENDENCY INJECTION

La possibilità di effettuare dependency injection nelle funzioni attraverso una macro come ad esempio:

```rust
    #[inject(RoundVM)]
    fn nbr<A: 'static + Clone>(&mut self, expr: impl Fn() -> A) -> A {
        ...
    }
```
permetterebbe di definire i costrutti fondamentali come funzioni pure e non metodi di un oggetto, rendendo possibile scrivere codice di questo tipo:

```rust
    let result = rep(||0, |a| nbr(||a) + 1);
```

in quanto non vengono effettuati borrowing problematici.

E importante sottolineare che ad oggi non sembra esistere un framework di dependency injection in Rust in grado di realizzare il codice sopra riportato, ma sarebbe possibile esplorare la soluzione reallizzandolo attraverso il macro system di Rust.