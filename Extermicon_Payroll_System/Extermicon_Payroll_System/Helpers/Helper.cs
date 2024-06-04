using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Extermicon_Payroll_System.Helpers
{
    public static class Helper
        //Helps to convert into safe way
    {
        public static int StringToInt(string stringValue)
        {
            int value;
            Int32.TryParse(stringValue, out value);
            return value;
        }

        public static DateTime StringToDateTime(string stringValue)
        {
            DateTime value;
            DateTime.TryParse(stringValue, out value);
            return value;
        }

        public static double StringToDouble(string stringValue)
        {
            double value;
            double.TryParse(stringValue, out value);
            return value;
        }

        public static decimal DoubleToDecimal(double doubleValue)
        {
            decimal value;
            decimal.TryParse(doubleValue.ToString(), out value);
            return value;
        }

        public static double DecimalToDouble(decimal doubleValue)
        {
            double value;
            double.TryParse(doubleValue.ToString(), out value);
            return value;
        }
    }
}