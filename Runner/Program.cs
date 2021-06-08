using Microsoft.Quantum.Simulation.Simulators;
using System;
using System.Threading.Tasks;
using Quantum.QLib;
using Microsoft.Quantum.Simulation.Core;
using System.Collections.Generic;

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

            const int MaxRandom = 10;
            Console.WriteLine($"Random numbers 0..{MaxRandom}:");
            var results = new List<long>(iterations);
            for(int i = 0; i < iterations; i++)
            {
                results.Add(await Rng.Run(sim, MaxRandom));
            }

            Console.WriteLine(string.Join(",", results));

            Console.WriteLine("=======================");

            await DeutschJozsa.Run(sim, new ConstantOne(sim));
            await DeutschJozsa.Run(sim, new Balanced(sim));
            await DeutschJozsa.Run(sim, new ConstantZero(sim));
            await DeutschJozsa.Run(sim, new BalancedOpposite(sim));
        }
    }
}
