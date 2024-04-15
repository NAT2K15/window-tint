$(function() {
    $("body").hide();
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            $("body").show();
            console.log(`showing body`);
            $('#tint').html(`<b>${item.tint}</b>`); // item.tint
        }
    });

    window.addEventListener('keyup', function(event) {
        if (event.keyCode == 27 || event.keyCode == 116) {
            $("body").hide();
            $.post(`https://${GetParentResourceName()}/exit`, {});
        }
    });

    $('#container').draggable();
});