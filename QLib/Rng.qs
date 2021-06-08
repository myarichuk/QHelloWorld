namespace Quantum.QLib {

    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Measurement;

    operation Rng (max : Int) : Int {
        let qbitCount = BitSizeI(max); //how many qbits we need to represent "max"?
        use qs = Qubit[qbitCount]; //allocate enough qbits to calculate the random number
        
        ApplyToEach(H, qs); //apply 50/50 superposition (Hadamard Gate) to each qubit in the array
        
        let measureRes = MultiM(qs); //measure each qubit in array

        ResetAll(qs); //reset all qubits once we are finished working with them
        let randomNum = ResultArrayAsInt(measureRes); //convert bits to integer
        return randomNum > max ? Rng(max) | randomNum; //if we "overflow" the max number, try again
    }
}
