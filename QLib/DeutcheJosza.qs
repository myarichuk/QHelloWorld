namespace Quantum.QLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    //credit: some stuff taken/adapted from https://www.strathweb.com/2021/02/introduction-to-quantum-computing-with-q-part-15-deutsch-jozsa-algorithm/

    // f(q1) = 0
    //note: assuming q2 is "untouched" -> is in |0> state
    operation ConstantZero(q1 : Qubit, q2 : Qubit) : Unit is Adj {
    }

    // f(q1) = 1
    //note: assuming q2 is "untouched" -> is in |0> state
    operation ConstantOne(q1 : Qubit, q2 : Qubit) : Unit is Adj {
        X(q2); //this flips the state of q2
    }

    //CNOT is pretty much quantum version of XOR
    //see https://en.wikipedia.org/wiki/Controlled_NOT_gate
    operation Balanced(q : Qubit, q2 : Qubit) : Unit is Adj  {
        CNOT(q, q2);
    }

    operation BalancedOpposite(q : Qubit, q2 : Qubit) : Unit is Adj {
        CNOT(q,q2);
        X(q2);
    }

    operation DeutschJozsa(oracle : ((Qubit, Qubit) => Unit)) : Bool {
        mutable isFunctionConstant = true;
        use q = Qubit(); //when initialized, qubit is at state |0>
        use q2 = Qubit();

        X(q2); //flip this one to |1>

        H(q);
        H(q2);

        oracle(q, q2);

        H(q);

        // |0> means the functions is constant
        if (M(q) != Zero)
        {
            set isFunctionConstant = false;
        }

        Reset(q);
        Reset(q2);

        return isFunctionConstant;
    }
}
