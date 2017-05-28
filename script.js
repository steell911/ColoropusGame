function getRandomInt(min, max)
{
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getRandomByteFraction() {
    return getRandomInt(0, 255) / 256;
}

function getRandomColor(colorFunc) {
    return colorFunc(getRandomByteFraction(),
                     getRandomByteFraction(),
                     getRandomByteFraction(),
                     getRandomByteFraction());
}

function isValueInArray(value, array) {
    for(var i = 0; i < array.length; i++) {
        if(array[i] == value) {
            return true;
        }
    }
    return false;
}

function colorSum() {
    if(arguments.length < 2) {
        return arguments[arguments.length - 1](1, 1, 1, 1);
    }
    else {
        var r = 0, g = 0, b = 0;
        var colorQuantity = arguments.length - 1;
        for(var i = 0; i < colorQuantity; i++) {
            r += arguments[i].r;
            g += arguments[i].g;
            b += arguments[i].b;
        }
        r = r/colorQuantity;
        g = g/colorQuantity;
        b = b/colorQuantity;
        return arguments[arguments.length - 1](r, g, b, 1);
    }
}

function generateColorFromSet() {
    var length = arguments.length;
    var seed = arguments[arguments.length - 2];
    if((length < 3) || (seed > length - 2)) {
        return arguments[arguments.length - 1](1, 1, 1, 1);
    }
    else {
        var colorQuantity = length - 2;
        var array = [];
        for(var i = 0; i < seed; i++) {
            var randomValue = getRandomInt(0, colorQuantity - 1);
            while(isValueInArray(randomValue, array)) {
                randomValue = getRandomInt(0, colorQuantity - 1);
            }
            array[i] = randomValue;
        }
        var r = 0, g = 0, b = 0;
        for(var i = 0; i < seed; i++) {
            r += arguments[array[i]].r;
            g += arguments[array[i]].g;
            b += arguments[array[i]].b;
        }
        r = r/seed;
        g = g/seed;
        b = b/seed;
        return arguments[arguments.length - 1](r, g, b, 1);
    }

}

function colorsEqual(color1, color2) {
    return (color1.r == color2.r) &&
           (color1.g == color2.g) &&
           (color1.b == color2.b);
}
