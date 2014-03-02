@Calculator = angular.module('Calculator', [])

maxDecimals = 8
maxLength = 15

Calculator.controller 'CalculatorCtrl', ($scope) ->
	math = mathjs()
	errorTimeout = null

	$scope.cursorPosition = 0
	$scope.expression = ''

	$scope.insertChar = (char) -> $scope.expression += char
	$scope.clear = -> $scope.expression = ''
	$scope.evaluate = ->
		return unless $scope.expression
		try
			$scope.expression = truncate(math.eval($scope.expression.replace('×', '*')).toString())
		catch exception
			$scope.error = true
			clearTimeout(errorTimeout)
			errorTimeout = setTimeout((->
				$scope.$apply -> $scope.error = false
			), 1500)

truncate = (expression) ->
	parts = expression.split('.')
	return expression if parts.length == 1
	onesSectionLength = parts[0].length
	decimalSectionLength = Math.min(maxDecimals, maxLength - onesSectionLength)
	decimalSectionLength = 1 if decimalSectionLength < 1
	return parts[0] + '.' + parts[1][0..decimalSectionLength]