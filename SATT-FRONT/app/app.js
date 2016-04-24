'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute',
    'myApp.login',
    'myApp.eventos',
    'myApp.alertas',
    'myApp.nuevoEvento',
    'myApp.home'
]).
config(['$routeProvider', function ($routeProvider) {
    $routeProvider.otherwise({
        redirectTo: '/login'
    });
}])
.controller('IndexCtrl', ['$scope', '$localStorage', '$location', function ($scope, $localStorage, $location) {
    $scope.$storage = $localStorage;
    $scope.logOut = function () {
        delete $localStorage.userInfo;
        $location.path("/login");
    };
}]);