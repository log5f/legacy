////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.wordpress.com
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f
{
    import org.log5f.helpers.resources.ResourceManager;

    import org.log5f.events.LogEvent;

	[Deprecated(replacement="org.log5f.ILayout",since="1.0")]
    /**
     * The base class for all layouts.
     */
    public class Layout
    {
        //----------------------------------------------------------------------
        //
        //	Constructor
        //
        //----------------------------------------------------------------------

        /**
         * Constructor.
         */
        public function Layout()
        {
            super();
        }

        //----------------------------------------------------------------------
        //
        //	Properties
        //
        //----------------------------------------------------------------------

        /**
         * @return <code>true</code> if call stack is needed or <code>false</code>
         * otherwise.
         */
        public function get isStackNeeded():Boolean
        {
            return false;
        }

        //----------------------------------------------------------------------
        //
        //	Methods
        //
        //----------------------------------------------------------------------

        /**
         * Subclasses of <code>Layout</code> should implement this method to
         * perform actual logging.
         */
        public function format(event:LogEvent):String
        {
            throw new Error(ResourceManager.instance.
                            getString("errorAbstractMethod"));
        }
    }
}