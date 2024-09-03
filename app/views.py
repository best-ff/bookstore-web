from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.db.models import Sum

from .models import Product
from .models import User
from .models import Cart

# Page home </>

def home(request):

    user_name = request.GET.get('user_name', '')

    featured_product = Product.featured_product()

    recent_product = Product.recent_product()

    return render(request, 'home.html', {'featured_product': featured_product, 'recent_product': recent_product, 'user_name': user_name})

# Shop </>

def shop(request):
     
    user_name = request.GET.get('user_name', '')
     
    products = Product.objects.all()

    featured_product = Product.featured_product().first()

    return render(request, 'shop.html', {'products': products, 'featured_product': featured_product, 'user_name': user_name})

# Product </>

def product(request):

    user_name = request.GET.get('user_name', '')

    product_id = request.GET.get('product_id')

    product = get_object_or_404(Product, product_id=product_id)
    
    featured_product = Product.featured_product().first()

    return render(request, 'product.html', {'product': product, 'user_name': user_name, 'featured_product': featured_product})
# -
def add_cart_item(request):

    user_name = request.GET.get('user_name')

    product_id = request.GET.get('product_id')

    quantity = request.GET.get('quantity')

    Cart.objects.create(

        user=User.objects.get(user_name=user_name),

        product=Product.objects.get(product_id=product_id),

        quantity=quantity
    )

    return JsonResponse({})

# Login </>

def login(request):

    user_name = request.GET.get('user_name')

    return render(request, 'login.html', {'user_name': user_name})

# -

def check_login(request):

    user_name = request.GET.get('user_name')

    password = request.GET.get('password')
        
    users = User.objects.filter(user_name=user_name, password=password)
        
    if users.exists():

        return JsonResponse({'success': True})
        
    else:

        return JsonResponse({'success': False})
        

# Cart </>

def cart(request):

    user_name = request.GET.get('user_name')

    carts = Cart.objects.filter(user=user_name)

    total_amount = carts.aggregate(total_amount=Sum('total'))['total_amount'] or 0

    return render(request, 'cart.html', {'carts': carts, 'user_name': user_name, 'total_amount': total_amount})

# -

def update_cart_quantity(request):

    cart_id = request.GET.get('cart_id')

    quantity = request.GET.get('quantity')

    cart = Cart.objects.get(id=cart_id)
            
    cart.quantity = quantity

    cart.save()

    return JsonResponse({})

# -

def delete_cart_item(request): 

    cart_id = request.GET.get('cart_id')

    Cart.objects.filter(id=cart_id).delete()

    return JsonResponse({})

# Checkout </>

def checkout(request):

    user_name = request.GET.get('user_name')

    return render(request, 'checkout.html', {'user_name': user_name})
            


