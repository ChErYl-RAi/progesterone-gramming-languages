set:#choice 1
loc:st
show:select a number from 0 to 3.__
input:#choice
when:#choice & 0 (
    show:you have selected 0__
    jump:rmpc
)
when:#choice & 1 (
    show:you have selected 1__
    jump:rmpc
)
when:#choice & 2 (
    show:you have selected 2__
    jump:rmpc
)
when:#choice & 3 (
    show:you have selected 3__
    jump:rmpc
)
show:you have not selected a number from 0 to 3.__
jump:st
loc:rmpc
show:meow yay__