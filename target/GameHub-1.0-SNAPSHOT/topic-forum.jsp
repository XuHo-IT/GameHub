<%-- 
    Document   : topic-forum.jsp
    Created on : Oct 1, 2024, 11:12:00 AM
    Author     : OS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="card comment-section mt-5">
                        <div class="row no-gutters">
                            <div class="col-2 d-flex align-items-center justify-content-center">
                                <img src="img/author.jpg" width="70" class="rounded-circle mt-2">
                            </div>
                            <div class="col-10">
                                <div class="comment-box ml-3 p-3">
                                    <h4>Add a comment</h4>
                                    <div class="comment-area">
                                        <textarea class="form-control" placeholder="What is your view?" rows="4"></textarea>
                                    </div>
                                    <div class="comment-btns mt-3">
                                        <div class="row">
                                            <div class="col-6">
                                                <button class="btn btn-secondary btn-sm w-100">Cancel</button>
                                            </div>
                                            <div class="col-6">
                                                <button class="btn btn-primary btn-sm w-100">Send <i class="fa fa-long-arrow-right ml-1"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <h3>4 Comments</h3>
                    <br>
                    <!-- COMMENT 1 - START -->
                    <div class="media">
                        <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar1.png" alt=""></a>
                        <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            <ul class="list-unstyled list-inline media-detail pull-left">
                                <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                <li><i class="fa fa-thumbs-up"></i>13</li>
                            </ul>
                            <ul class="list-unstyled list-inline media-detail pull-right">
                                <li class=""><a href="">Like</a></li>
                                <li class=""><a href="">Reply</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- COMMENT 1 - END -->

                    <!-- COMMENT 2 - START -->
                    <div class="media">
                        <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar2.png" alt=""></a>
                        <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            <ul class="list-unstyled list-inline media-detail pull-left">
                                <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                <li><i class="fa fa-thumbs-up"></i>13</li>
                            </ul>
                            <ul class="list-unstyled list-inline media-detail pull-right">
                                <li class=""><a href="">Like</a></li>
                                <li class=""><a href="">Reply</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- COMMENT 2 - END -->

                    <!-- COMMENT 3 - START -->
                    <div class="media">
                        <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar3.png" alt=""></a>
                        <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            <ul class="list-unstyled list-inline media-detail pull-left">
                                <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                <li><i class="fa fa-thumbs-up"></i>13</li>
                            </ul>
                            <ul class="list-unstyled list-inline media-detail pull-right">
                                <li class=""><a href="">Like</a></li>
                                <li class=""><a href="">Reply</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- COMMENT 3 - END -->

                    <!-- COMMENT 4 - START -->
                    <div class="media">
                        <a class="pull-left" href="#"><img class="media-object" src="https://bootdey.com/img/Content/avatar/avatar4.png" alt=""></a>
                        <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            <ul class="list-unstyled list-inline media-detail pull-left">
                                <li><i class="fa fa-calendar"></i>27/02/2014</li>
                                <li><i class="fa fa-thumbs-up"></i>13</li>
                            </ul>
                            <ul class="list-unstyled list-inline media-detail pull-right">
                                <li class=""><a href="">Like</a></li>
                                <li class=""><a href="">Reply</a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- COMMENT 4 - END -->
    </body>
</html>
