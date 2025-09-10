using System;


  class Program

{
    static void Main(string[] args)

    {

        Console.Write("Digite o total de minutos: ");

    int minutosTotais = int.Parse(Console.ReadLine());

        int horas = minutosTotais / 60;

        int minutos = minutosTotais % 60;

        Console.WriteLine($"{minutosTotais} minutos equivalem a {horas} hora(s).");
    }
}


