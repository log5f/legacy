////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core
{
    import org.log5f.events.LogEvent;
    import org.log5f.filters.Filter;
    import org.log5f.helpers.resources.ResourceManager;

    /**
     * The base class for all appenders.
     */
    public class Appender implements IAppender
    {
        //----------------------------------------------------------------------
        //
        //	Constructor
        //
        //----------------------------------------------------------------------

        /**
         * Constructor.
         */
        public function Appender()
        {
            super();
        }

        //----------------------------------------------------------------------
        //
        //	Variables
        //
        //----------------------------------------------------------------------

        /**
         * @private
         * The head filter.
         */
        private var headFilter:Filter = null;

        /**
         * @private
         * The tail filter.
         */
        private var tailFilter:Filter = null;

        //----------------------------------------------------------------------
        //
        //	Properties
        //
        //----------------------------------------------------------------------

        //-----------------------------------
        //	name
        //-----------------------------------

        /**
         * @private
         * Storage for the name property.
         */
        private var _name:String;

        /**
         * @inheritDoc
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
            if (value === this._name)
                return;

            this._name = value;
        }

        //-----------------------------------
        //	layout
        //-----------------------------------

        /**
         * @private
         * Storage for the layout property.
         */
        private var _layout:ILayout;

        /**
         * @inheritDoc
         */
        public function get layout():ILayout
        {
            return this._layout;
        }

        /**
         * @private
         */
        public function set layout(value:ILayout):void
        {
            if (value === this._layout)
                return;

            this._layout = value;
        }

        //-----------------------------------
        //	filter
        //-----------------------------------

        /**
         * @inheritDoc
         */
        public function get filter():Filter
        {
            return this.headFilter;
        }

        /**
         * @inheritDoc
         */
        public function set filter(value:Filter):void
        {
            this.addFilter(value);
        }

        //----------------------------------------------------------------------
        //
        //	Methods
        //
        //----------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function addFilter(filter:Filter):void
        {
            if (!this.headFilter)
            {
                this.headFilter = this.tailFilter = filter;
            }
            else
            {
                this.tailFilter.next = filter;
                this.tailFilter = filter;
            }
        }

        /**
         * @inheritDoc
         */
        public function clearFilters():void
        {
            this.headFilter = this.tailFilter = null;
        }

        /**
         * Subclasses of <code>Appender</code> should implement this
         * method to perform actual logging.
         */
        protected function append(event:LogEvent):void
        {
            throw new Error(ResourceManager.instance.
                            getString("errorAbstractMethod"));
        }

        /**
         * This method performs threshold checks and invokes filters before
         * delegating actual logging to the subclasses specific.
         */
        public function doAppend(event:LogEvent):void
        {
            var filter:Filter = this.headFilter;

            FILTER_LOOP: while (filter)
            {
                switch (filter.decide(event))
                {
                    case Filter.DENY:
                    {
                        return;
                    }

                    case Filter.NEUTRAL:
                    {
                        filter = filter.next;

                        break;
                    }

                    case Filter.ACCEPT:
                    {
                        break FILTER_LOOP;
                    }
                }
            }

            this.append(event);
        }

        /**
         * @inheritDoc
         */
        public function close():void
        {
            this.layout = null;

            this.clearFilters();
        }

    }
}