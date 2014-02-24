@Calculator = angular.module('Calculator', [])

Calculator.controller 'CalculatorCtrl', ($scope) ->
	math = mathjs()
	errorTimeout = null

	$scope.cursorPosition = 0
	$scope.expression = ''

	$scope.insertChar = (char) -> $scope.expression += char
	$scope.clear = -> $scope.expression = ''
	$scope.evaluate = ->
		try
			$scope.expression = math.eval($scope.expression.replace('×', '*'))
		catch exception
			$scope.error = true
			clearTimeout(errorTimeout)
			errorTimeout = setTimeout((->
				$scope.$apply -> $scope.error = false
			), 1500)