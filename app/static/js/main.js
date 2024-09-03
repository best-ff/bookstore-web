(function ($) {
  "use strict";

  // Dropdown on mouse hover
  $(document).ready(function () {
    function toggleNavbarMethod() {
      if ($(window).width() > 768) {
        $(".navbar .dropdown")
          .on("mouseover", function () {
            $(".dropdown-toggle", this).trigger("click");
          })
          .on("mouseout", function () {
            $(".dropdown-toggle", this).trigger("click").blur();
          });
      } else {
        $(".navbar .dropdown").off("mouseover").off("mouseout");
      }
    }
    toggleNavbarMethod();
    $(window).resize(toggleNavbarMethod);
  });

  // Back to top button
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $(".back-to-top").fadeIn("slow");
    } else {
      $(".back-to-top").fadeOut("slow");
    }
  });
  $(".back-to-top").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 1500, "easeInOutExpo");
    return false;
  });

  // Home page slider
  $(".main-slider").slick({
    autoplay: true,
    dots: true,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    centerMode: true,
    variableWidth: true,
  });

  // Product Slider 4 Column
  $(".product-slider-4").slick({
    autoplay: true,
    infinite: true,
    dots: false,
    slidesToShow: 4,
    slidesToScroll: 1,
    responsive: [
      {
        breakpoint: 1200,
        settings: {
          slidesToShow: 4,
        },
      },
      {
        breakpoint: 992,
        settings: {
          slidesToShow: 3,
        },
      },
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 2,
        },
      },
      {
        breakpoint: 576,
        settings: {
          slidesToShow: 1,
        },
      },
    ],
  });

  // Product Slider 3 Column
  $(".product-slider-3").slick({
    autoplay: true,
    infinite: true,
    dots: false,
    slidesToShow: 3,
    slidesToScroll: 1,
    responsive: [
      {
        breakpoint: 992,
        settings: {
          slidesToShow: 3,
        },
      },
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 2,
        },
      },
      {
        breakpoint: 576,
        settings: {
          slidesToShow: 1,
        },
      },
    ],
  });

  // Single Product Slider
  $(".product-slider-single").slick({
    infinite: true,
    dots: false,
    slidesToShow: 1,
    slidesToScroll: 1,
  });

  // Brand Slider
  $(".brand-slider").slick({
    speed: 1000,
    autoplay: true,
    autoplaySpeed: 1000,
    infinite: true,
    arrows: false,
    dots: false,
    slidesToShow: 5,
    slidesToScroll: 1,
    responsive: [
      {
        breakpoint: 992,
        settings: {
          slidesToShow: 4,
        },
      },
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 3,
        },
      },
      {
        breakpoint: 576,
        settings: {
          slidesToShow: 2,
        },
      },
      {
        breakpoint: 300,
        settings: {
          slidesToShow: 1,
        },
      },
    ],
  });

  // Quantity
  $(document).ready(function () {
    var totalSum = 0;

    $(".qty button").on("click", function () {
      var $button = $(this);
      var $input = $button.siblings("input");
      var oldValue = parseInt($input.val());
      var maxValue = parseInt($input.attr("max-quantity"));

      var newVal = $button.hasClass("btn-plus")
        ? Math.min(oldValue + 1, maxValue)
        : Math.max(oldValue - 1, 0);

      $input.val(newVal);
      updateTotal($(this).closest("tr"));
    });

    function updateTotal($row) {
      var quantity = parseInt($row.find(".quantity").val());
      var price = parseFloat($row.find(".price").text());
      var total = quantity * price;
      totalSum += total;
      $(".sub-total").text("$" + totalSum.toFixed(2));
      $row.find(".total-cost").text("$" + total.toFixed(2));
    }
  });

  // Add cart item
  $(document).ready(function () {
    $(".add-cart-item").on("click", function (e) {
      e.preventDefault();
      var user_name = $(this).attr("user");
      var product_id = $(this).attr("product");
      var quantity = $("#quantity").val();
      $.ajax({
        type: "GET",
        url: "/add_cart_item/",
        data: {
          user_name: user_name,
          product_id: product_id,
          quantity: quantity,
        },
        success: function () {},
      });
    });
  });

  // Submit to login
  $(document).ready(function () {
    $("#login_btn").click(function () {
      var user_name = $("#user_name").val();
      var password = $("#password").val();
      $.ajax({
        url: "/check_login/",
        method: "GET",
        data: {
          user_name: user_name,
          password: password,
        },
        success: function (data) {
          if (data.success) {
            window.location.href = "/home/?user_name=" + user_name;
          } else {
            alert("Login failed!");
          }
        },
      });
    });
  });

  // Update cart quantity
  $(document).ready(function () {
    $(".update-cart").on("click", function () {
      $(".table.table-bordered tbody tr").each(function () {
        var cart_id = $(this).find(".delete-cart-item").attr("data-cart-id");
        var quantity = $(this).find(".quantity").val();
        $.ajax({
          url: "/update_cart_quantity/",
          method: "GET",
          data: { cart_id: cart_id, quantity: quantity },
          success: function (response) {
            location.reload();
          },
        });
      });
    });
  });

  // Delete cart item
  $(document).ready(function () {
    var array_item_delete = [];
    $(".delete-cart-item").on("click", function () {
      var cart_id = $(this).data("cart-id");
      array_item_delete.push(cart_id);
      $("#" + cart_id).hide();
    });
    $(".update-cart").on("click", function () {
      array_item_delete.forEach(function (cart_id) {
        $.ajax({
          url: "/delete-cart-item/",
          method: "GET",
          data: { cart_id: cart_id },
          success: function () {
            location.reload();
          },
        });
      });
    });
  });

  // Checkout
  $(document).ready(function () {
    $(".checkout-btn").click(function () {
      alert("You have placed your order successfully");
    });
  });

  // Shipping address show hide
  $(".checkout #shipto").change(function () {
    if ($(this).is(":checked")) {
      $(".checkout .shipping-address").slideDown();
    } else {
      $(".checkout .shipping-address").slideUp();
    }
  });

  // Payment methods show hide
  $(".checkout .payment-method .custom-control-input").change(function () {
    if ($(this).prop("checked")) {
      var checkbox_id = $(this).attr("id");
      $(".checkout .payment-method .payment-content").slideUp();
      $("#" + checkbox_id + "-show").slideDown();
    }
  });
})(jQuery);
