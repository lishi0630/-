from django import template
register = template.Library()
@register.filter(name='abc')
def abc(value):
    return value.split(",")