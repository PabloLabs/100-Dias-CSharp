using System;

class Program
{
    static void Main(string[] args)
    {
        Console.Write("Digite o valor do lado do quadrado:");
        double lado = double.Parse(Console.ReadLine());

        double area = lado * lado;

        Console.WriteLine($"A área do quadrado é: {area:F2}");
    }
}