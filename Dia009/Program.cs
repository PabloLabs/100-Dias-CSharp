using System;

class Program

{
    static void Main(String[] args)
{
    Console.Write("Digite um numero inteiro para ver a tabuada: ");
    int numero = int.Parse(Console.ReadLine());

    Console.WriteLine($"Tabuada do {numero}:");

    for (int i = 1; i <= 10; i++)
    {
        int resultado = numero * i;
        Console.WriteLine($"{numero} x {i} = {resultado}");
    }

}

    }
