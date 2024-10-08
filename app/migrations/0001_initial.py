# Generated by Django 3.2 on 2024-09-03 14:33

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('product_id', models.AutoField(primary_key=True, serialize=False)),
                ('product_name', models.CharField(max_length=255)),
                ('star_rating', models.IntegerField()),
                ('quantity', models.IntegerField()),
                ('short_description', models.TextField()),
                ('detailed_description', models.TextField()),
                ('ingredients', models.TextField()),
                ('regular_price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('discount_price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('image_url', models.URLField()),
            ],
            options={
                'db_table': 'tb_product',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('user_name', models.CharField(max_length=50, primary_key=True, serialize=False)),
                ('password', models.CharField(max_length=100)),
                ('first_name', models.CharField(max_length=50)),
                ('last_name', models.CharField(max_length=50)),
                ('email', models.EmailField(max_length=100)),
                ('mobile_no', models.CharField(blank=True, max_length=20, null=True)),
            ],
            options={
                'db_table': 'tb_user',
            },
        ),
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField()),
                ('total', models.DecimalField(decimal_places=2, max_digits=10)),
                ('product', models.ForeignKey(db_column='product', on_delete=django.db.models.deletion.CASCADE, to='app.product')),
                ('user', models.ForeignKey(db_column='user', on_delete=django.db.models.deletion.CASCADE, to='app.user')),
            ],
            options={
                'db_table': 'tb_cart',
            },
        ),
    ]
