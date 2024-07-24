let points = [];
let canvas, ctx, image;

function getMousePos(canvas, evt) {
    let rect = canvas.getBoundingClientRect();
    return {
        x: evt.clientX - rect.left,
        y: evt.clientY - rect.top
    };
}

function drawPolygon() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.drawImage(image, 0, 0);

    if (points.length > 0) {
        ctx.beginPath();
        ctx.moveTo(points[0].x, points[0].y);

        for (let i = 1; i < points.length; i++) {
            ctx.lineTo(points[i].x, points[i].y);
        }

        ctx.closePath();
        ctx.strokeStyle = 'red';
        ctx.lineWidth = 2;
        ctx.stroke();
    }
}

function calculateArea() {
    const formattedPoints = points.map(point => [point.x, point.y]);
    $.ajax({
        type: 'POST',
        url: '/calculate_area',
        contentType: 'application/json',
        data: JSON.stringify({
            points: formattedPoints,
            latitude: 13.1038889,
            zoom: 21
        }),
        success: function(response) {
            $('#result').text(`Area: ${response.area.toFixed(2)} square feet`);
        }
    });

    
}

function cutPolygon() {
    const formattedPoints = points.map(point => [point.x, point.y]);

    $.ajax({
        type: 'POST',
        url: '/cut_polygon',
        contentType: 'application/json',
        data: JSON.stringify({ points: formattedPoints }),
        success: function(response) {
            const newImageUrl = response.image_url;
            $('#cut-image').attr('src', newImageUrl);
        }
    });
}
    
function cutPolygon() {
    const formattedPoints = points.map(point => [point.x, point.y]);

    $.ajax({
        type: 'POST',
        url: '/cut_polygon',
        contentType: 'application/json',
        data: JSON.stringify({ points: formattedPoints }),
        success: function(response) {
            const newImageUrl = response.image_url;
            window.location.href = '/solar_panels'; // Redirect to new Three.js page
        }
    });
}


$(document).ready(function() {
    canvas = document.getElementById('drawing-canvas');
    ctx = canvas.getContext('2d');
    image = document.getElementById('satellite-image');

    // Set canvas size to match the image size
    canvas.width = image.width;
    canvas.height = image.height;
    ctx.drawImage(image, 0, 0);

    canvas.addEventListener('click', function(evt) {
        let pos = getMousePos(canvas, evt);
        points.push(pos);
        drawPolygon();
    });
    calculateArea();
    $('#calculate-area-btn').click(calculateArea);
    $('#cut-polygon-btn').click(cutPolygon);
});
