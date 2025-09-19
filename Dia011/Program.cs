using System;

class Program
{
    static void Main()
    {
        string resposta;
        do
        {
            Console.Write("Deseja Continuar? (S/N): ");
            resposta = Console.ReadLine().ToUpper();

            if (resposta != "S" && resposta != "N")
            {
                Console.WriteLine("Digite S para sim ou N para não.");
            }
        }
        while (resposta != "N");

        Console.WriteLine("Encerrando programa...");
    }
}
