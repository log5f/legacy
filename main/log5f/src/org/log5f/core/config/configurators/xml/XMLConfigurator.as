////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 http://log5f.org
// This program is made available under the terms of the MIT License.
////////////////////////////////////////////////////////////////////////////////

package org.log5f.core.config.configurators.xml
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.utils.StringUtil;
	
	import org.log5f.Level;
	import org.log5f.LoggerManager;
	import org.log5f.core.Appender;
	import org.log5f.core.IAppender;
	import org.log5f.core.config.configurators.IConfigurator;
	import org.log5f.error.AppenderNotFoundError;
	import org.log5f.error.ClassNotFoundError;
	import org.log5f.error.IllegalArgumentError;
	import org.log5f.error.InvalidAppenderError;
	import org.log5f.error.InvalidConfigError;
	import org.log5f.error.SingletonError;
	import org.log5f.log5f_internal;
	
	[ExcludeClass]
	
	/**
	 * The implementation of IConfigurator that configures Log5F from XML.
	 */
	public class XMLConfigurator implements IConfigurator
	{
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private static var instance:IConfigurator;
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		public static function getInstance():IConfigurator
		{
			if (!instance)
				instance = new XMLConfigurator();
			
			return instance;
		}
		
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function XMLConfigurator()
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
		 */
		private var properties:XML;
		
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	isConfigured
		//-----------------------------------
		
		/**
		 * @private 
		 */
		private var _isConfigured:Boolean = false;
		
		/**
		 * @inheritDoc
		 */
		public function get isConfigured():Boolean
		{
			return _isConfigured;
		}
		
		//-----------------------------------
		//	traceErrors
		//-----------------------------------
		
		/**
		 * @private 
		 */
		private var _traceErrors:Boolean = true;
		
		/**
		 * @inheritDoc
		 */
		public function get traceErrors():Boolean
		{
			return this._traceErrors;
		}
		
		//----------------------------------------------------------------------
		//
		//	Methods
		//
		//----------------------------------------------------------------------
		
		//-----------------------------------
		//	Methods: IConfigurator
		//-----------------------------------
		
		/**
		 * Configures Log5F from specified XML object.
		 * 
		 * @throws InvalidConfigError If configuration XML is invalid
		 * @throws InvalidAppenderError If configuration for appender is invalid.
		 * @throws AppenderNotFoundError If configuration for some appender name 
		 * is not exist in config
		 * @throws ClassNotFoundError If some class is not exist in current 
		 * application domain.
		 * @throws IllegalArgumentError Caused by ArgumentError
		 */
		public function configure(source:Object):Boolean
		{
			this.properties = XML(source);
			
			this._traceErrors = !(properties.@traceErrors == "false");
			
			for each (var logger:XML in properties.logger)
			{
				this.configureLogger(logger);
			}
			
			if (properties.root.length() > 0)
			{
				this.configureLogger(properties.root[0]);
			}
			
			return true;
		}

		//-----------------------------------
		//	Methods: Internal
		//-----------------------------------
		
		/**
		 * Creates and configures logger by xml description.
		 * 
		 * @param logger The XML node for configuration of concrete logger.
		 */
		private function configureLogger(logger:XML):void
		{
			if (logger.@name.toString() == "" && 
				logger.name().toString() != LoggerManager.ROOT_LOGGER_NAME)
			{
				throw new InvalidConfigError();
			}
			
			var name:String = logger.@name.toString() == "" ? 
				LoggerManager.ROOT_LOGGER_NAME : 
				logger.@name.toString();
			
			// add level
			
			LoggerManager.getLogger(name).level = 
				(logger.@level != null && logger.@level.toString() != "") ? 
				Level.toLevel(logger.@level.toString()) : 
				null;
			
			// add appenders
			
			var appenders:Array = 
				StringUtil.trimArrayElements(logger.@appenders, ",").split(",");
			
			for each (var appenderName:String in appenders)
			{
				var node:XML = properties.appender.(@name == appenderName)[0];
				
				var appender:IAppender = this.createAppender(node);
				
				LoggerManager.getLogger(name).addAppender(appender);
			}
		}
		
		//-----------------------------------
		//	Methods: Creating actors
		//-----------------------------------
		
		/**
		 * Creates and return an appender by specified xml node.
		 *
		 * @param node The node from <code>properties</code> XML that describes
		 * concrete appender.
		 *
		 * @return The created appender.
		 *
		 * @trows InvalidConfigError, AppenderNotFoundError, InvalidAppenderError
		 */
		private function createAppender(node:XML):IAppender
		{
			var name:String = node.@name.toString();
			
			var className:String = node.attribute("class").toString();
			
			if (!name || name == "")
				throw new InvalidConfigError();
			
			if (!className || className == "")
				throw new InvalidConfigError();
			
			try
			{
				var Appender:Class = this.createClass(className);
				var appender:IAppender = new Appender();
			}
			catch (e:ClassNotFoundError)
			{
				throw new AppenderNotFoundError(className);
			}
			catch (e:VerifyError)
			{
				throw new InvalidAppenderError(className);
			}
			
			appender.name = name;
			
			this.addParams(appender, node);
			
			return appender;
		}
		
		//-----------------------------------
		//	Methods: Utility
		//-----------------------------------
		
		/**
		 * The utility method that returns Class by it name.
		 *
		 * @param className The name of class that will be returned.
		 *
		 * @return The founded class
		 *
		 * @see getDefinitionByName
		 */
		private function createClass(className:String):Class
		{
			className = this.classNameFormat(className);
			
			try
			{
				var Type:Class = getDefinitionByName(className) as Class;
			}
			catch (e:ReferenceError)
			{
				throw new ClassNotFoundError(className);
			}
			
			return Type;
		}
		
		/**
		 * The utility method that formats specifies class name.
		 *
		 * @param className The class name that need format.
		 *
		 * @return The Formatted class name.
		 */
		private function classNameFormat(className:String):String
		{
			if (className.indexOf("::") != -1)
				return className;
			
			if (className.indexOf(".") == -1)
				return className;
			
			var colon:uint = className.lastIndexOf(".");
			
			return className.substring(0, colon) + "::" + 
				className.substring(colon + 1, className.length);
		}
		
		/**
		 * @throws IllegalArgumentError, ClassNotFoundError
		 */
		private function addParams(target:Object, node:XML):void
		{
			if (!target || !node)
				return;
			
			for each (var param:XML in node.param)
			{
				var type:String = param.@type.toString();
				var name:String = param.@name.toString();
				var value:Object = param.@value.toString();
				
				if (!name || name == "" || !value)
					throw new InvalidConfigError();
				
				switch (type)
				{
					case ParamType.CLASS :
					{
						var Type:Class = this.createClass(String(value));
						
						try
						{
							value = new Type();
						}
						catch (e:ArgumentError)
						{
							throw new IllegalArgumentError(String(value));
						}
						
						break;
					}
						
					case ParamType.NUMBER :
					{
						value = Number(value);
						
						break;
					}
						
					case ParamType.STRING :
					{
						value = value;
						
						break;
					}
						
					case ParamType.BOOLEAN :
					{
						value = (value == "true" || value == "yes");
						
						break;
					}
						
					default:
					{
						throw new InvalidConfigError();
						
						break;
					}
				}
				
				try
				{
					target[name] = value;
				}
				catch (error:TypeError)
				{
					throw new ClassNotFoundError(getQualifiedClassName(value));
				}
				
				this.addParams(value, param);
			}
		}
	}
}