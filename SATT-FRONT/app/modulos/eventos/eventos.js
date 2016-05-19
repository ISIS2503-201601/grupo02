'use strict';

angular.module('myApp.eventos', ['ngRoute','ui.bootstrap'])

.run(function(uibPaginationConfig){
    uibPaginationConfig.firstText='Primero';
    uibPaginationConfig.previousText='Anterior';
    uibPaginationConfig.lastText='Último';
    uibPaginationConfig.nextText='Siguiente';
  })

.config(['$routeProvider', function ($routeProvider) {
    $routeProvider.when('/eventos', {
        templateUrl: 'modulos/eventos/eventos.html',
        controller: 'EventosCtrl'
    });
}])

.controller('EventosCtrl', ['$scope', '$http', '$localStorage', function ($scope, $http, $localStorage) {
    $http({
        method: 'GET',
        url: 'http://uniandes-satt.herokuapp.com/eventos',
//        url: 'http://localhost:8010/eventos'
        //url: 'http://localhost:8080/eventos',
        headers: {
            "Authorization": $localStorage.userInfo !== undefined ? $localStorage.userInfo.accessToken : null
        }
    }).then(function successCallback(response) {
        $scope.eventos = response.data;
        
        //Paginacion
        $scope.filteredEventos = []
        ,$scope.currentPage = 1
        ,$scope.numPerPage = 10
        ,$scope.maxSize = 5;
  
        $scope.$watch('currentPage + numPerPage', function() {
        var begin = (($scope.currentPage - 1) * $scope.numPerPage)
        , end = begin + $scope.numPerPage;
    $scope.filteredEventos = $scope.eventos.slice(begin, end);
  });
        
    }, function errorCallback(response) {
        if(response.status == 401) {
            $scope.error = "Oh oh! Parece que requieres permisos que no te han otorgado :(";
        } else {
            $scope.error = "Oh oh! Hubo un problema. Lo sentimos, intenta mas tarde :(";   
        }
    });
}]);