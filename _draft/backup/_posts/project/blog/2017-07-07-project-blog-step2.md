---
layout: post
title: "[Blog] spring boot로 블로그 만들어보기2 - UI 테마 적용"
date: 2017-07-07 17:40:00
projects: blog
tags: spring spring-boot ui
---

블로그로 만들지…이전에 만들고 싶었던 가계부로 갈지…   
읽은 책을 관리하기 위한 프로젝트로 갈지….     
갈팡질팡 중이다….(먼가 컨셉을 잡아야하는데…흐으으음….)           

일단은 블로그 컨셉으로 가면서 게시판이랑 공부해보고 싶은 것들에 대한 샘플 페이지를 만들어보면서 결정을 해야겠다.    
만약, 컨셉을 바꾸게 되면….정리한 글들의 제목이랑 프로젝트명을 아마도 수정해야 겠지??     
     
일단은 오늘 하고 있는 것들 정리…

## UI 테마 검색
UI 개발에 참고할 템플릿을 github에서 검색하여 [AdminLTE](https://github.com/almasaeed2010/AdminLTE)라는 템플릿을 적용하기로 했다.      
디자인도 깔끔하고 다양한 컴포넌트 들에 대한 설정들, 그리고 화면 구성도 마음에 들었다. 
![](https://camo.githubusercontent.com/e3bbc646d6ff473da2dd6cede2c968846a6982a6/68747470733a2f2f61646d696e6c74652e696f2f41646d696e4c5445322e706e67)    

##  UI 테마 반영
그대로 해당 테마를 반영할 것이라 아니라 참고해서 만들 예정이라서 다음과 같은 순서로 AdminLTE 테마에서 레이아웃을 가져왔다.    

#### 모듈 설치
AdminLTE에서 사용하는 패키지를 `bower`를 이용하여 설치한다. (나는 “node + bower + gulp”를 이용하여 구성할 계획이므로….)     
설치할 패키지는 아래와 같다.
```
bower install jquery bootstrap font-awesome --save
```

####  AdminLTE 커스텀 라이브러리 복사
`dist`에 위치한 아래의 파일들을 원하는 위치로 복사한다.   
```
assets/
├── css
│   ├── AdminLTE.css
│   └── skins
│       ├── _all-skins.css
│       ├── skin-black-light.css
│       ├── skin-black.css
│       ├── skin-blue-light.css
│       ├── skin-blue.css
│       ├── skin-green-light.css
│       ├── skin-green.css
│       ├── skin-purple-light.css
│       ├── skin-purple.css
│       ├── skin-red-light.css
│       ├── skin-red.css
│       ├── skin-yellow-light.css
│       └── skin-yellow.css
└── js
    └── adminlte.js
```
      
> 기회가 되면 css로 작성된 파일들은 차후에 sass나 less를 이용하여 변경해볼까함.  

#### 초기 페이지 작성
`starter.html` 파일을 참고해서 불필요한 부분은 제거하고 아래와 같이 작성하였음.
```
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

        <title>Sample App:Main</title>

          <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.min.css">
          <!-- Font Awesome -->
          <link rel="stylesheet" href="bower_components/font-awesome/css/font-awesome.min.css">

        <!-- Theme style -->
        <link rel="stylesheet" href="assets/css/AdminLTE.css">
          <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
      page. However, you can choose any other skin. Make sure you
      apply the skin class to the body tag so the changes take effect. -->
            <link rel="stylesheet" href="assets/css/skins/skin-blue.css">
    </head>
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
                <!-- Main Header -->
              <header class="main-header">

                <!-- Logo -->
                <a href="/" class="logo">
                  <!-- mini logo for sidebar mini 50x50 pixels -->
                  <span class="logo-mini"><b>A</b>LT</span>
                  <!-- logo for regular state and mobile devices -->
                  <span class="logo-lg"><b>Admin</b>LTE</span>
                </a>

                <!-- Header Navbar -->
                <nav class="navbar navbar-static-top" role="navigation">
                  <!-- Sidebar toggle button-->
                  <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                    <span class="sr-only">Toggle navigation</span>
                  </a>
                  <!-- Navbar Right Menu -->
                  <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                      <!-- User Account Menu -->
                      <li class="dropdown user user-menu notifications-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                          <!-- The user image in the navbar-->
                          <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                          <!-- hidden-xs hides the username on small devices so only the image appears. -->
                          <span class="hidden-xs">Alexander Pierce</span>
                        </a>
                        <!-- Inner menu: contains the tasks -->
                    <ul class="dropdown-menu">
                          <li>
                            <!-- Inner menu: contains the tasks -->
                            <ul class="menu">
                              <li><!-- Task item -->
                                <a href="#">Sign out</a>
                              </li>
                            </ul>
                          </li>
                        </ul>
                      </li>
                      <!-- Control Sidebar Toggle Button -->
                      <li>
                        <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                      </li>
                    </ul>
                  </div>
                </nav>
              </header>

                <!-- Left side column. contains the logo and sidebar -->
              <aside class="main-sidebar">

                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">

                  <!-- search form (Optional) -->
                  <form action="#" method="get" class="sidebar-form">
                    <div class="input-group">
                      <input type="text" name="q" class="form-control" placeholder="Search...">
                      <span class="input-group-btn">
                          <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                          </button>
                        </span>
                    </div>
                  </form>
                  <!-- /.search form -->

                  <!-- Sidebar Menu -->
                  <ul class="sidebar-menu" data-widget="tree">
                    <li class="header">MENU</li>
                    <!-- Optionally, you can add icons to the links -->
                    <li class="active"><a href="#"><i class="fa fa-link"></i> <span>Link</span></a></li>
                    <li><a href="#"><i class="fa fa-link"></i> <span>Another Link</span></a></li>
                    <li class="treeview">
                      <a href="#"><i class="fa fa-link"></i> <span>Multilevel</span>
                        <span class="pull-right-container">
                            <i class="fa fa-angle-left pull-right"></i>
                          </span>
                      </a>
                      <ul class="treeview-menu">
                        <li><a href="#">Link in level 2</a></li>
                        <li><a href="#">Link in level 2</a></li>
                      </ul>
                    </li>
                  </ul>
                  <!-- /.sidebar-menu -->
                </section>
                <!-- /.sidebar -->
              </aside>

              <!-- Content Wrapper. Contains page content -->
              <div class="content-wrapper">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                  <h1>
                    Page Header
                    <small>Optional description</small>
                  </h1>
                  <ol class="breadcrumb">
                    <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                    <li class="active">Here</li>
                  </ol>
                </section>

                <!-- Main content -->
                <section class="content container-fluid">

                  <!--------------------------
                    | Your Page Content Here |
                    -------------------------->

                </section>
                <!-- /.content -->
              </div>
              <!-- /.content-wrapper -->

              <!-- Main Footer -->
              <footer class="main-footer">
                <!-- To the right -->
                <div class="pull-right hidden-xs">
                  Anything you want
                </div>
                <!-- Default to the left -->
                <strong>Copyright &copy; 2016 <a href="#">Company</a>.</strong> All rights reserved.
              </footer>

              <!-- Control Sidebar -->
              <aside class="control-sidebar control-sidebar-dark">
                <!-- Create the tabs -->
                <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                  <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
                  <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                  <!-- Home tab content -->
                  <div class="tab-pane active" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading">Recent Activity</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;">
                          <i class="menu-icon fa fa-birthday-cake bg-red"></i>

                          <div class="menu-info">
                            <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                            <p>Will be 23 on April 24th</p>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                    <h3 class="control-sidebar-heading">Tasks Progress</h3>
                    <ul class="control-sidebar-menu">
                      <li>
                        <a href="javascript:;">
                          <h4 class="control-sidebar-subheading">
                            Custom Template Design
                            <span class="pull-right-container">
                                <span class="label label-danger pull-right">70%</span>
                              </span>
                          </h4>

                          <div class="progress progress-xxs">
                            <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                          </div>
                        </a>
                      </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                  </div>
                  <!-- /.tab-pane -->
                  <!-- Stats tab content -->
                  <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
                  <!-- /.tab-pane -->
                  <!-- Settings tab content -->
                  <div class="tab-pane" id="control-sidebar-settings-tab">
                    <form method="post">
                      <h3 class="control-sidebar-heading">General Settings</h3>

                      <div class="form-group">
                        <label class="control-sidebar-subheading">
                          Report panel usage
                          <input type="checkbox" class="pull-right" checked>
                        </label>

                        <p>
                          Some information about this general settings option
                        </p>
                      </div>
                      <!-- /.form-group -->
                    </form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
              </aside>
              <!-- /.control-sidebar -->
              <!-- Add the sidebar's background. This div must be placed
              immediately after the control sidebar -->
              <div class="control-sidebar-bg"></div>

        </div>

        <!-- jQuery 3 -->
        <script src="bower_components/jquery/dist/jquery.min.js"></script>
        <!-- Bootstrap 3.3.7 -->
        <script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <!-- AdminLTE App -->
        <script src="assets/js/adminlte.js"></script>
    </body>
</html>
```
      
웹서버를 실행하면 아래와 같은 화면을 확인할 수 있다.   
![]({{ site.url }}/assets/images/post/2017/0706-spring-blog-project-ui-index.png)  
    
> *Project 과정에 대한 글 리스트*    
> 1. [spring boot로 블로그 만들어보기]({% post_url project/blog/2017-07-06-project-blog-step1 %})