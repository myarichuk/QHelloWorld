namespace Quantum.QLib {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    //credit: some stuff taken/adapted from https://www.strathweb.com/2021/02/introduction-to-quantum-computing-with-q-part-15-deutsch-jozsa-algorithm/

    // f(q1) = 0
    operation ConstantZero(q1 : Qubit, q2 : Qubit) : Unit is Adj {
    }

    // f(q1) = 1
    operation ConstantOne(q1 : Qubit, q2 : Qubit) : Unit is Adj {
        X(q2);
    }

    //f(0) = 1, f(1) = 0
    operation Balanced(q : Qubit, q2 : Qubit) : Unit is Adj  {
        CNOT(q, q2);
    }

    operation BalancedOpposite(q : Qubit, q2 : Qubit) : Unit is Adj {
        CNOT(q,q2);
        X(q2);
    }

    operation DeutschJozsa(oracle : ((Qubit, Qubit) => Unit)) : Unit {
        use q = Qubit();
        use q2 = Qubit();

        X(q2); //start from |1>

        H(q);
        H(q2);

        oracle(q, q2);

        H(q);

        // |0> means the functions is constant
        if (M(q) != Zero)
        {
            Message("Balanced");
        }
        else
        {
            Message("Constant");
        }

        Reset(q);
        Reset(q2);
    }
}
