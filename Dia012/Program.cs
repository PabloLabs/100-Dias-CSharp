using System;

class Program
{
    static void Main()
    {
        int tamanho = 5;
        double[] notas = new double[tamanho];
        double soma = 0;

        for (int i = 0; i < tamanho; i++)
        {
            Console.WriteLine("Digite a nota: ");
            notas[i] = double.Parse(Console.ReadLine());
            soma += notas[i];
        }

        double media = soma / tamanho;
        Console.WriteLine("Média: " + media);
    }
}
