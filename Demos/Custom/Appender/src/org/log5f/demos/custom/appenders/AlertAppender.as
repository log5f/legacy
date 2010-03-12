package org.log5f.demos.custom.appenders
{
    import mx.controls.Alert;
    
    import org.log5f.Appender;
    import org.log5f.events.LogEvent;
    
    /**
     * Shows log messages in Alert control.
     */
    public class AlertAppender extends Appender
    {
        //----------------------------------------------------------------------
        //
        //  Constructor
        //
        //----------------------------------------------------------------------
        
        /**
         * Constructor.
         */
        public function AlertAppender()
        {
            super();
        }
        
        //----------------------------------------------------------------------
        //
        //  Overridden methods
        //
        //----------------------------------------------------------------------
        
		/**
		 * Shows alert with log message.
		 */
        override protected function append(event:LogEvent):void
        {
            Alert.show(this.layout.format(event), event.level.toString(), Alert.OK);
        }
    }
}