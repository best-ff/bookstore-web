from django.db import models

class Product(models.Model):
    product_id = models.AutoField(primary_key=True)
    product_name = models.CharField(max_length=255)
    star_rating = models.IntegerField()
    quantity = models.IntegerField()
    short_description = models.TextField()
    detailed_description = models.TextField()
    ingredients = models.TextField()
    regular_price = models.DecimalField(max_digits=10, decimal_places=2)
    discount_price = models.DecimalField(max_digits=10, decimal_places=2)
    image_url = models.URLField()

    @classmethod
    def featured_product(cls):
        return cls.objects.order_by('-quantity')[:6]
    
    @classmethod
    def recent_product(cls):
        return cls.objects.order_by('-product_id')[:6]


    class Meta:
        db_table = 'tb_product'

class User(models.Model):
    user_name = models.CharField(max_length=50, primary_key=True)
    password = models.CharField(max_length=100)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    email = models.EmailField(max_length=100)
    mobile_no = models.CharField(max_length=20, blank=True, null=True)

    class Meta:
        db_table = 'tb_user'
    
class Cart(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, db_column='user')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, db_column='product')
    quantity = models.IntegerField()
    total = models.DecimalField(max_digits=10, decimal_places=2)

    class Meta:
         db_table = 'tb_cart'