package org.puremvc.as3.test
{
    import flexunit.framework.AssertionFailedError;
    import flexunit.framework.TestCase;
 
    import org.puremvc.as3.core.View;
    import org.puremvc.as3.interfaces.INotification;
    import org.puremvc.as3.patterns.observer.Observer;
 
    public class PureMvcTestCase extends TestCase
    {
 
        private var expectedNotificationNames:Array = [];
        private var actualNotifications:Array = [];
 
        public function PureMvcTestCase(methodName:String=null)
        {
            super(methodName);
        }
 
        protected function expectNotification(notificationName:String):void
        {
            assertNotNull('No instance exists for View.getInstance()', View.getInstance());
            expectedNotificationNames.push(notificationName);
 
            View.getInstance().registerObserver(notificationName, new Observer(
                function(notification:INotification):void {
                    actualNotifications.push(notification);
                },
                null));
        }
 
        protected function get lastActualNotification():INotification
        {
            if (actualNotifications.length == 0) {
                return null;
            }
            return actualNotifications[actualNotifications.length - 1];
        }
 
        protected function assertExpectedNotificationsOccurred(userMessage='The expected notifications were not sent'):void
        {
            var actualNotificationNames:Array = [];
 
            for(var notificationIndex:int = 0; notificationIndex < actualNotifications.length; notificationIndex++) {
                actualNotificationNames.push(actualNotifications[notificationIndex].getName());
            }
 
            assertArraysEqual(expectedNotificationNames, actualNotificationNames, userMessage);
        }
 
        protected function assertArraysEqual(expected:Array, actual:Array, userMessage:String = null):void
        {
            var equal:Boolean = (expected.length == actual.length);
 
            if (equal) {
                for(var i:int = 0; i < actualNotifications.length; i++) {
                    if (expected[i] != actual[i]) {
                        equal = false;
                        break;
                    }
                }
            }
 
            if (!equal) {
                if (userMessage &amp;&amp; userMessage.length > 0) {
                    userMessage += ' - ';
                }
 
                throw new AssertionFailedError(userMessage + 'Expected: <' + expected + '> but was: <' + actual + '>');
            }
        }
    }
}

