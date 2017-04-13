# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

angular.module('App', ['ngMaterial']).controller('UrlShortsCtrl', ['$scope', '$http', ($scope, $http)->
  $scope.on_AjaxReq = false
  $scope.form_data = {
    original_url: {
      content: '',
      error_content:'',
      error_visible: false
    },
    short_url: {
      content: '',
      error_content:'',
      error_visible: false
    },
    common_error: {
      error_content:'',
      error_visible: false
    },
    short_url_result: {
      content:'',
      visible: false
    }
  }
  set_error = (obj, description)->
    obj.error_content = description
    obj.error_visible = true
    
  $scope.get_short_link = ()->
    $scope.on_AjaxReq = true
    $scope.form_data.short_url_result.visible = false
    $scope.form_data.common_error.error_visible = false
    data = {
      url_short: {
        original_url: $scope.form_data.original_url.content,
        short_url: $scope.form_data.short_url.content
      }
    }
    $http.post('/url_shorts', data).then(
      (response)->
        data = response.data
        if data.error
          switch  data.whose
            when 'original_url'
              set_error($scope.form_data.original_url, data.description)
            when 'short_url'
              set_error($scope.form_data.short_url, data.description)
            else
              set_error($scope.form_data.common_error, data.description)
        else
          $scope.form_data.short_url_result.content = data.url_short
          $scope.form_data.short_url_result.visible = true
        $scope.on_AjaxReq = false
      ,
      (response)->
        set_error($scope.form_data.common_error, response.statusText)
        $scope.on_AjaxReq = false
    );
])