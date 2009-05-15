/**
 * Додати відкаладене завантаження до завантаження файлу з налаштунками.
 */
package org.log5f
{
    import flash.events.Event;
    
    import org.log5f.events.LogEvent;

    public class Category implements IAppenderAttachable
    {
        //----------------------------------------------------------------------
        //
        //	Class constants
        //
        //----------------------------------------------------------------------



        //----------------------------------------------------------------------
        //
        //	Constructor
        //
        //----------------------------------------------------------------------

        /**
         * Constructor.
         */
        public function Category(name:String)
        {
            this.name = name;
        }

        //----------------------------------------------------------------------
        //
        //	Variables
        //
        //----------------------------------------------------------------------

        private var appenders:AppenderAttachable;

        [ArrayElementType("LogObject")]
        private var lazyLogEvents:Array;

        //----------------------------------------------------------------------
        //
        //	Properties
        //
        //----------------------------------------------------------------------

        //-----------------------------------
        //	name
        //-----------------------------------

        /**
         * Storage for the name property.
         */
        private var _name:String;

        /**
         *
         */
        public function get name():String
        {
            return this._name;
        }

        /**
         * @private
         */
        public function set name(value:String):void
        {
            this._name = value;
        }

        //-----------------------------------
        //	level
        //-----------------------------------

        /**
         * Storage for the level property.
         */
        private var _level:Level;

        /**
         *
         */
        public function get level():Level
        {
            return this._level;
        }

        /**
         * @private
         */
        public function set level(value:Level):void
        {
            this._level = value;
        }

        //-----------------------------------
        //	filter
        //-----------------------------------

        /**
         * Storage for the filter property.
         */
        private var _filter:IFilter;

        /**
         *
         */
        public function get filter():IFilter
        {
            return this._filter;
        }

        /**
         * @private
         */
        public function set filter(value:IFilter):void
        {
            this._filter = value;
        }

        //-----------------------------------
        //	parent
        //-----------------------------------

        /**
         * Storage for the category property.
         */
        private var _parent:Category;

        /**
         * The parent category, for root category this property is <code>null</code>.
         */
        public function get parent():Category
        {
            return this._parent;
        }

        /**
         * @private
         */
        public function set parent(value:Category):void
        {
            this._parent = value;
            
            this.category = this.name;
            
//			this.category = this.parent != LoggerManager.getRootLogger() ?
//							this.parent.name :
//							this.name;
        }

        //-----------------------------------
        //	category
        //-----------------------------------

        /**
         * Storage for the category property.
         */
        private var _category:String;

        /**
         *
         */
        public function get category():String
        {
            return this._category;
        }

        /**
         * @private
         */
        public function set category(value:String):void
        {
            this._category = value;
        }

        //----------------------------------------------------------------------
        //
        //	Methods
        //
        //----------------------------------------------------------------------

        public function addAppender(appender:IAppender):void
        {
            if (!this.appenders)
                this.appenders = new AppenderAttachable();

            this.appenders.addAppender(appender);
        }

        public function getAllAppenders():Array
        {
            if (!this.appenders)
                return null;

            return this.appenders.getAllAppenders();
        }

        public function getAppender(name:String):IAppender
        {
            if (!this.appenders)
                return null;

            return this.appenders.getAppender(name);
        }

        public function isAttached(appender:IAppender):Boolean
        {
            if (!this.appenders)
                return false;

            return this.appenders.isAttached(appender);
        }

        public function removeAllAppenders():void
        {
            if (!this.appenders)
                return;

            return this.appenders.removeAllAppenders();
        }

        public function removeAppender(key:Object):void
        {
            if (!this.appenders)
                return;

            return this.appenders.removeAppender(key);
        }

        public function debug(message:Object):void
        {
            this.log(Level.DEBUG, message);
        }

        public function info(message:Object):void
        {
            this.log(Level.INFO, message);
        }

        public function warn(message:Object):void
        {
            this.log(Level.WARN, message);
        }

        public function error(message:Object):void
        {
            this.log(Level.ERROR, message);
        }

        public function fatal(message:Object):void
        {
            this.log(Level.FATAL, message);
        }

        public function getEffectiveLevel():Level
        {
            for (var c:Category = this; c != null; c = c.parent)
            {
                if (c.level)
                    return c.level;
            }

            return null;
        }

        public function callAppenders(event:LogEvent):void
        {
            for each (var appender:IAppender in this.getAllAppenders())
            {
                appender.doAppend(event);
            }
        }

        public function toString():String
        {
            return '[Category name="' + this.name + '" level="' + this.level.toString() + '"]';
        }

        // --------------- PROTECTED METHODS -------------- //

        protected function log(level:Level, message:Object, stack:String=null):void
        {
            if (!PropertyConfigurator.configured)
            {
                PropertyConfigurator.addEventListener(Event.COMPLETE, 
                                                      this.propertiesCompleteHandler);

                this.lazyLog(level, message, stack);

                return;
            }

            if (!level.isGreaterOrEqual(this.getEffectiveLevel()))
                return;

            var event:LogEvent = new LogEvent(this, level, message);

            if (!this.isLoggable(event))
                return;

            for (var c:Category = this; c != null; c = c.parent)
            {
                if (level.isGreaterOrEqual(c.getEffectiveLevel()))
                    c.callAppenders(event);
            }
        }

        protected function lazyLog(level:Level, message:Object, stack:String=null):void
        {
            if (this.lazyLogEvents == null)
                this.lazyLogEvents = [];

            this.lazyLogEvents.push(new LogObject(level, message, stack));
        }

        // ---------------- PRIVATE METHODS --------------- //

        private function isLoggable(event:LogEvent):Boolean
        {
            if (this.filter == null)
                return true;

            return this.filter.isLoggable(event);
        }

        // ------------------- HANDLERS ------------------- //

        protected function propertiesCompleteHandler(event:Event):void
        {
            PropertyConfigurator.
            	removeEventListener(Event.COMPLETE, 
            						this.propertiesCompleteHandler);

            if (this.lazyLogEvents == null || this.lazyLogEvents.length == 0)
                return;

            var data:LogObject = this.lazyLogEvents.shift() as LogObject;

            while (data)
            {
                this.log(data.level, data.message);

                data = this.lazyLogEvents.shift() as LogObject;
            }
        }

        // --------------- USER INTERACTION --------------- //

    }
}

import org.log5f.Level;

class LogObject
{
    public var level:Level;

    public var message:Object;

    public var stack:String;

    function LogObject(level:Level=null, message:Object=null, stack:String=null)
    {
        super();

        this.level = level;
        this.message = message;
        this.stack = stack;
    }
}