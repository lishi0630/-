from django import template
register = template.Library()
@register.filter(name='abc1')
def abc1(value):
    return value.split("|")