namespace Quantum.QLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    //taken from https://github.com/microsoft/Quantum/blob/main/samples/interoperability/qrng/Qrng.qs
    operation HeadOrTails () : Result
    {
        // Allocate a qubit.
        use q = Qubit();

        // Put the qubit to superposition by applying Hadamard transform. It now has a 50% chance of being 0 or 1.
        H(q);

        // Measure the qubit value. This collapses the qubit into one of it's eigenvalues.
        let r = M(q);

        //before releasing qubits, we need to reset them to 'ground state' of |0>
        Reset(q);
        return r;
    }
}