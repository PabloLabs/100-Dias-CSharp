using System;

class Program
{
    static void Main(string[] args)
    {
    Console.Write("Digite o primeiro número (dividendo):");
    int numero1 = int.Parse(Console.ReadLine());

    Console.Write("Digite o segundo número (divisor):");
    int numero2 = int.Parse(Console.ReadLine());

    int resto = numero1 % numero2;

    Console.WriteLine($"O resto da divisão de {numero1} por {numero2} é: {resto}");


}
}