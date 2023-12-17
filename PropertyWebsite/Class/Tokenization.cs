using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;

namespace PropertyWebsite.Class
{
    public class Tokenization
    {
        public static string GenerateToken(string credential)
        {
            byte[] plaintextBytes = Encoding.UTF8.GetBytes(credential);
            byte[] encryptedBytes = MachineKey.Protect(plaintextBytes);
            string encryptedText = Convert.ToBase64String(encryptedBytes);
            return encryptedText;
        }

        public static string InterpreteToken(string token)
        {
            byte[] encryptedBytes = Convert.FromBase64String(token);
            byte[] plaintextBytes = MachineKey.Unprotect(encryptedBytes);
            string plaintext = Encoding.UTF8.GetString(plaintextBytes);
            return plaintext;
        }

        public static void main(string[] args)
        {
            Console.WriteLine(GenerateToken("abc"));
            Console.WriteLine(InterpreteToken(GenerateToken("abc")));
        }
    }
}