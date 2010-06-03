////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    import org.log5f.error.AppenderNotFoundError;
    import org.log5f.error.CallAbstractMethodError;
    import org.log5f.error.ClassNotFoundError;
    import org.log5f.error.DocumentInvalidError;
    import org.log5f.error.FileNotFoundError;
    import org.log5f.error.IllegalArgumentError;
    import org.log5f.error.InvalidAppenderError;
    import org.log5f.error.InvalidConfigError;
    import org.log5f.error.SingletonError;
    import org.log5f.helpers.resources.ResourceManager;

	/**
	 * Loads configuration file.
	 */
    public class PropertyLoader
    {
        //----------------------------------------------------------------------
        //
        //	Class constatns
        //
        //----------------------------------------------------------------------

        /**
         * The name of configuration file.
         */
        public static const FILE:String = "log5f.properties";

        //----------------------------------------------------------------------
        //
        //	Class variables
        //
        //----------------------------------------------------------------------

        /**
         * The request of configuration file that used by <code>loader</code>.
         */
        private static var request:URLRequest = new URLRequest(FILE);

        /**
         * The loader that loads configuration file.
         */
        private static var loader:URLLoader = new URLLoader();

        /**
         * The flag that indicates if configuration file is loaded.
         */
        private static var loaded:Boolean = false;

        //----------------------------------------------------------------------
        //
        //	Constructor
        //
        //----------------------------------------------------------------------

        /**
         * Constructor.
         */
        public function PropertyLoader()
        {
            super();
        }

        //----------------------------------------------------------------------
        //
        //	Variables
        //
        //----------------------------------------------------------------------

        //----------------------------------------------------------------------
        //
        //	Properties
        //
        //----------------------------------------------------------------------

        //----------------------------------------------------------------------
        //
        //	Methods
        //
        //----------------------------------------------------------------------

        //----------------------------------
        //	Methods: Common
        //----------------------------------

        /**
         * Loads configuration file, if it is not loaded.
         */
        public static function load():void
        {
            if (!PropertyLoader.loaded)
            {
                PropertyLoader.loaded = true;

                PropertyLoader.loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);

                PropertyLoader.loader.addEventListener(IOErrorEvent.IO_ERROR,
                                                       loaderIOErrorHandler);

                PropertyLoader.loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
                                                       loaderSecurityErrorHandler);

                PropertyLoader.loader.load(request);
            }
        }

        //----------------------------------------------------------------------
        //
        //	Event handlers
        //
        //----------------------------------------------------------------------

        /**
         * The handler of "complete" event of <code>loader</code>.
         *
         * Initiates configuration of Log5F if loaded configuration file is XML.
         *
         * @param event The event.
         */
        protected static function loaderCompleteHandler(event:Event):void
        {
            var properties:XML = new XML(URLLoader(event.target).data);
			
            try
            {
                PropertyConfigurator.configure(properties);
            }
            catch (error:Error)
            {
                if (PropertyConfigurator.traceErrors)
                    trace("Log5F:", error.getStackTrace());
            }
        }

        /**
         * The handler of "ioError" event of <code>loader</code>.
         *
         * Sets <code>loaded</code> to <code>false</code>.
         *
         * @param event The Input/Output Error event.
         */
        protected static function loaderIOErrorHandler(event:IOErrorEvent):void
        {
            PropertyLoader.loaded = false;
			
			if (PropertyConfigurator.traceErrors)
				trace("Log5F:", event.text);
        }

        /**
         * The handler of "securityError" event of <code>loader</code>.
         *
         * Sets <code>loaded</code> to <code>false</code>.
         *
         * @param event The Security Error event.
         */
        protected static function loaderSecurityErrorHandler(event:SecurityErrorEvent):void
        {
            PropertyLoader.loaded = false;
			
			if (PropertyConfigurator.traceErrors)
				trace("Log5F:", event.text);
        }
    }
}