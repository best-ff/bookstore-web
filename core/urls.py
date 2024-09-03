"""core URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.views.generic import RedirectView
from app import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', RedirectView.as_view(url='/home/')),
    path('home/', views.home, name='home'), 
] + [
    path('shop/', views.shop, name='shop'),
] + [
    path('product/', views.product, name='product'),
    path('add_cart_item/', views.add_cart_item, name='add_cart_item'),
] + [
    path('login/', views.login, name='login'),
    path('check_login/', views.check_login, name='check_login'),
] + [
    path('cart/', views.cart, name='cart'),
    path('delete-cart-item/', views.delete_cart_item, name='delete_cart_item'),
    path('update_cart_quantity/', views.update_cart_quantity, name='update_cart_quantity'),] + [
    path('checkout/', views.checkout, name='checkout'),
]
