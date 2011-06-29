////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.helpers.formatters
{
    import mx.formatters.StringFormatter;
	
	//-------------------------------------
	//	Other metadata
	//-------------------------------------
	
	[ExcludeClass]
	
    /**
     */
    public class DateFormatter
    {
        //----------------------------------------------------------------------
        //
        //  Class constants
        //
        //----------------------------------------------------------------------

        /** @private */
        private static const VALID_PATTERN_CHARS:String = 
			"Y,M,D,A,E,H,J,K,L,N,S,Q";
		
        /** @private */
		private static const timeOfDay:Array = ["AM", "PM"];
		
        /** @private */
		private static const dayNamesLong:Array = 
			["Sunday", "Monday", "Tuesday", "Wednesday", 
				"Thursday", "Friday", "Saturday"];
		
        /** @private */
		private static const dayNamesShort:Array = 
			["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		
        /** @private */
		private static const monthNamesLong:Array = 
			["January", "February", "March", "April", "May", "June", 
			 "July", "August", "September", "October", "November", "December"];

        /** @private */
		private static const monthNamesShort:Array = 
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
			 "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		
        //----------------------------------------------------------------------
        //
        //  Class properties
        //
        //----------------------------------------------------------------------

        //----------------------------------
        //  defaultStringKey
        //----------------------------------

        /**
         *  @private
         */
        private static function get defaultStringKey():Array
        {
            return monthNamesLong.concat(timeOfDay);
        }
		
		//----------------------------------------------------------------------
		//
		//  Class methods
		//
		//----------------------------------------------------------------------

        /**
         *  @private
         */
        private static function extractTokenDate(date:Date,
                                                 tokenInfo:Object):String
        {
            var result:String = "";

            var key:int = int(tokenInfo.end) - int(tokenInfo.begin);

            var day:int;
            var hours:int;

            switch (tokenInfo.token)
            {
                case "Y":
                {
                    var year:String = date.getFullYear().toString();
                    if (key < 3)
                        return year.substr(2);
                    else if (key > 4)
                        return setValue(Number(year), key);
                    else
                        return year;
                }

                case "M":
                {
                    var month:int = int(date.getMonth());
                    if (key < 3)
                    {
                        month++;
                        result += setValue(month, key);
                        return result;
                    }
                    else if (key == 3)
                    {
                        return monthNamesShort[month];
                    }
                    else
                    {
                        return monthNamesLong[month];
                    }
                }

                case "D":
                {
                    day = int(date.getDate());
                    result += setValue(day, key);
                    return result;
                }

                case "E":
                {
                    day = int(date.getDay());
                    if (key < 3)
                    {
                        result += setValue(day, key);
                        return result;
                    }
                    else if (key == 3)
                    {
                        return dayNamesShort[day];
                    }
                    else
                    {
                        return dayNamesLong[day];
                    }
                }

                case "A":
                {
                    hours = int(date.getHours());
                    if (hours < 12)
                        return timeOfDay[0];
                    else
                        return timeOfDay[1];
                }

                case "H":
                {
                    hours = int(date.getHours());
                    if (hours == 0)
                        hours = 24;
                    result += setValue(hours, key);
                    return result;
                }

                case "J":
                {
                    // hour in day (0-23)
                    hours = int(date.getHours());
                    result += setValue(hours, key);
                    return result;
                }

                case "K":
                {
                    // hour in am/pm (0-11)
                    hours = int(date.getHours());
                    if (hours >= 12)
                        hours = hours - 12;
                    result += setValue(hours, key);
                    return result;
                }

                case "L":
                {
                    // hour in am/pm (1-12)
                    hours = int(date.getHours());
                    if (hours == 0)
                        hours = 12;
                    else if (hours > 12)
                        hours = hours - 12;
                    result += setValue(hours, key);
                    return result;
                }

                case "N":
                {
                    var mins:int = int(date.getMinutes());
                    result += setValue(mins, key);
                    return result;
                }

                case "S":
                {
                    var sec:int = int(date.getSeconds());
                    result += setValue(sec, key);
                    return result;
                }

                case "Q":
                {
                    var ms:int = int(date.getMilliseconds());
                    result += setValue(ms, key);
                    return result;
                }
            }

            return result;
        }
		
		private static function setValue(value:Object, key:int):String
		{
			var result:String = "";
			
			var vLen:int = value.toString().length;
			if (vLen < key)
			{
				var n:int = key - vLen;
				for (var i:int = 0; i < n; i++)
				{
					result += "0"
				}
			}
			
			result += value.toString();
			
			return result;
		}
		
        //--------------------------------------------------------------------------
        //
        //  Class methods
        //
        //--------------------------------------------------------------------------

        /**
         *
         */
        public static function parseDateString(str:String):Date
        {
            if (!str || str == "")
                return null;

            var year:int = -1;
            var mon:int = -1;
            var day:int = -1;
            var hour:int = -1;
            var min:int = -1;
            var sec:int = -1;

            var letter:String = "";
            var marker:Object = 0;

            var count:int = 0;
            var len:int = str.length;

            var timezoneRegEx:RegExp = /(GMT|UTC)((\+|-)\d\d\d\d )?/ig;

            str = str.replace(timezoneRegEx, "");

            while (count < len)
            {
                letter = str.charAt(count);
                count++;

                if (letter <= " " || letter == ",")
                    continue;

                if (letter == "/" || letter == ":" || letter == "+" || letter == "-")
                {
                    marker = letter;
                    continue;
                }

                if ("a" <= letter && letter <= "z" || "A" <= letter && letter <= "Z")
                {
                    var word:String = letter;
                    while (count < len)
                    {
                        letter = str.charAt(count);
                        if (!("a" <= letter && letter <= "z" || "A" <= letter && letter <= "Z"))
                        {
                            break;
                        }
                        word += letter;
                        count++;
                    }

                    var n:int = DateFormatter.defaultStringKey.length;
                    for (var i:int = 0; i < n; i++)
                    {
                        var s:String = String(DateFormatter.defaultStringKey[i]);
                        if (s.toLowerCase() == word.toLowerCase() || s.toLowerCase().substr(0,
                                                                                            3) == word.toLowerCase())
                        {
                            if (i == 13)
                            {
                                if (hour > 12 || hour < 1)
                                    break;
                                else if (hour < 12)
                                    hour += 12;
                            }
                            else if (i == 12)
                            {
                                if (hour > 12 || hour < 1)
                                    break;
                                else if (hour == 12)
                                    hour = 0;

                            }
                            else if (i < 12)
                            {
                                if (mon < 0)
                                    mon = i;
                                else
                                    break;
                            }
                            break;
                        }
                    }
                    marker = 0;
                }

                else if ("0" <= letter && letter <= "9")
                {
                    var numbers:String = letter;
                    while ("0" <= (letter = str.charAt(count)) && letter <= "9" && count < len)
                    {
                        numbers += letter;
                        count++;
                    }
                    var num:int = int(numbers);

                    if (num >= 70)
                    {
                        if (year != -1)
                        {
                            break;
                        }
                        else if (letter <= " " || letter == "," || letter == "." || letter == "/" || letter == "-" || count >= len)
                        {
                            year = num;
                        }
                        else
                        {
                            break; 
                        }
                    }

                    else if (letter == "/" || letter == "-" || letter == ".")
                    {
                        if (mon < 0)
                            mon = (num - 1);
                        else if (day < 0)
                            day = num;
                        else
                            break;
                    }

                    else if (letter == ":")
                    {
                        if (hour < 0)
                            hour = num;
                        else if (min < 0)
                            min = num;
                        else
                            break;
                    }

                    else if (hour >= 0 && min < 0)
                    {
                        min = num;
                    }

                    else if (min >= 0 && sec < 0)
                    {
                        sec = num;
                    }

                    else if (day < 0)
                    {
                        day = num;
                    }

                    else if (year < 0 && mon >= 0 && day >= 0)
                    {
                        year = 2000 + num;
                    }

                    else
                    {
                        break;
                    }

                    marker = 0
                }
            }

            if (year < 0 || mon < 0 || mon > 11 || day < 1 || day > 31)
                return null;

            if (sec < 0)
                sec = 0;
            if (min < 0)
                min = 0;
            if (hour < 0)
                hour = 0;

            var newDate:Date = new Date(year, mon, day, hour, min, sec);
            if (day != newDate.getDate() || mon != newDate.getMonth())
                return null;

            return newDate;
        }

        //--------------------------------------------------------------------------
        //
        //  Constructor
        //
        //--------------------------------------------------------------------------

        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 9
         *  @playerversion AIR 1.1
         *  @productversion Flex 3
         */
        public function DateFormatter()
        {
            super();
        }

        //--------------------------------------------------------------------------
        //
        //  Properties
        //
        //--------------------------------------------------------------------------

        //----------------------------------
        //  formatString
        //----------------------------------

        /**
         *  @private
         *  Storage for the formatString property.
         */
        private var _formatString:String;

        /**
         *  @private
         */
        private var formatStringOverride:String;

        [Inspectable(category="General", defaultValue="null")]

        /**
         *
         */
        public function get formatString():String
        {
            return _formatString;
        }

        /**
         *  @private
         */
        public function set formatString(value:String):void
        {
            formatStringOverride = value;

            _formatString = value != null ? value : "MM/DD/YYYY";
        }

        //--------------------------------------------------------------------------
        //
        //  Methods
        //
        //--------------------------------------------------------------------------

        /**
         * 
         */
        public function format(value:Object):String
        {
            if (!value || (value is String && value == ""))
            {
                return "";
            }

            if (value is String)
            {
                value = DateFormatter.parseDateString(String(value));
                if (!value)
                {
                    return "";
                }
            }
            else if (!(value is Date))
            {
                return "";
            }

            var letter:String;
            var nTokens:int = 0;
            var tokens:String = "";

            var n:int = formatString.length;
            for (var i:int = 0; i < n; i++)
            {
                letter = formatString.charAt(i);
                if (VALID_PATTERN_CHARS.indexOf(letter) != -1 && letter != ",")
                {
                    nTokens++;
                    if (tokens.indexOf(letter) == -1)
                    {
                        tokens += letter;
                    }
                    else
                    {
                        if (letter != formatString.charAt(Math.max(i - 1, 0)))
                        {
                            return "";
                        }
                    }
                }
            }

            if (nTokens < 1)
            {
                return "";
            }

            var dataFormatter:StringFormatter = new StringFormatter(
                formatString, VALID_PATTERN_CHARS,
                DateFormatter.extractTokenDate);

            return dataFormatter.formatValue(value);
        }
    }

}
