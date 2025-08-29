﻿using System;

class Program
{
    static void Main()
    {
        Console.WriteLine("Digite seu nome:");
        string nome = Console.ReadLine();

        Console.WriteLine("Digite sua idade:");
        string idadeTexto = Console.ReadLine();
        int idade = int.Parse(idadeTexto);  // Converte texto para número inteiro

        Console.WriteLine("Seu nome é " + nome + " e você tem " + idade + " anos.");
    }
}