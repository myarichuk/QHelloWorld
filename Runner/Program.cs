using Microsoft.Quantum.Simulation.Simulators;
using System;
using System.Threading.Tasks;
using Quantum.QLib;
using Microsoft.Quantum.Simulation.Core;

namespace Runner
{
    //playing around with Q# :)
    class Program
    {
        static async Task Main(string[] args)
        {
            using var sim = new QuantumSimulator();
            await HelloQ.Run(sim);
            Console.WriteLine("=======================");
            Console.WriteLine("Random number gen: experimenting with Hadamard Gate");

            var oneCount = 0;
            var zeroCount = 0;
            const int iterations = 100;
            for (int i = 0; i < iterations; i++)
            {
                var measureResult = await HeadOrTails.Run(sim);
                if (measureResult.GetValue() == ResultValue.One)
                    oneCount++;
                else
                    zeroCount++;
            }
            Console.WriteLine($"Out of {iterations} measurements, Hadamard Gate yielded {zeroCount} heads and {oneCount} tails");
            Console.WriteLine("=======================");
        }
    }
}
