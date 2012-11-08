<!DOCTYPE html>
<html>
<head>
  <title>Budget</title>
  <!--[if lt IE 9]>
  <script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
  <![endif]-->
  <%= stylesheet_link_tag    "application", :media => "all" %>
  <%= javascript_include_tag "application" %>
  <%= csrf_meta_tags %>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<div class="container">
  <% flash.each do |name, msg| %>
    <%= content_tag :div, msg, class: "alert alert-#{name}" %>
  <% end %>
</div>

<div class="navbar navbar-inverse navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <%= link_to 'Budget', root_path, class: 'brand' %>
      <div class="nav-collapse collapse">
      <% if user_signed_in? %>
        <ul class="nav">
          <li class="active"><a href="#">Home</a></li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Incomes <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="#">New</a></li>
              <li><a href="#">All</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Expenses <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="#">New</a></li>
              <li><a href="#">All</a></li>
            </ul>
            <ul class="dropdown-menu">
              <li><a href="#">New</a></li>
              <li><a href="#">All</a></li>
            </ul>
          </li>
          <%# end %>
        </ul>
        <ul class="nav pull-right">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <%= current_user.email %> <b class="caret"></b>
            </a>
            <ul class="dropdown-menu">
              <li><%= link_to 'Edit profile', edit_user_registration_path, :class => "btn btn-large btn-primary" %></li>
              <li><%= link_to 'Logout', destroy_user_session_path, method: :delete , :class => "btn btn-large btn-primary" %></li>
            </ul>
          </li>
          <ul class="dropdown-menu">
          </ul>
        </ul>
      <% else %>
        <p class="navbar-text pull-right">
          <%= link_to "Sign up", new_user_registration_path, :class => "btn btn-small btn-primary" %> |
          <%= link_to "Login", new_user_session_path, :class => "btn btn-small btn-primary" %>
        </p>
      <% end %>
      </div>
    </div>
  </div>
</div>

<div class="container">
  <div class="row">
    <div class="span12">
      <div class="row">
      <%= yield %>
      </div>
    </div>
  </div>
</div>

<div class="container">
<footer class="span4 offset4">
  <p>Project Budget 2012 | Ragnarson</p>
</footer>
</div>

</body>
</html>

