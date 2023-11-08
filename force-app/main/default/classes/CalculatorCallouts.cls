public with sharing class CalculatorCallouts {
    
    public static void addNumbers(Double a, Double b) {
        CalculatorServices.CalculatorImplPort service = new CalculatorServices.CalculatorImplPort();
        Double result = service.doAdd(a, b);
        System.debug('result: ' + result);
    }

    public static void multiplyNumbers(Double a, Double b) {
        CalculatorServices.CalculatorImplPort service = new CalculatorServices.CalculatorImplPort();
        Double result = service.doMultiply(a, b);
        System.debug('result: ' + result);
    }

    public static void divideNumbers(Double a, Double b) {
        CalculatorServices.CalculatorImplPort service = new CalculatorServices.CalculatorImplPort();
        Double result = service.doDivide(a, b);
        System.debug('result: ' + result);
    }
}