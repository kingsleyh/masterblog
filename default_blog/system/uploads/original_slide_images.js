function slidePortfolioIndex($time, $full_image_width) {
	
	$addCustom = $(".index_port_item.current").length;
	if($addCustom == 0) {
		$(".index_port_item:first").addClass("current");
	}
	
	//This part takes care of setting the right width for the portfolio tiles depending on the number of portfolio items you've got.
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	$totalPortfolio = ($(".index_port_item").length) - 1; // Get the total number of tiles we will have
	$widthDivide = 920 - $full_image_width; //Defines the total space we have for the tiles depending on your full size image
	$tileWidth = parseInt($widthDivide / $totalPortfolio);
	
	$caption_width = $full_image_width - 63;
	
	$caption_width = $caption_width + 'px';
	$full_image_width = $full_image_width + 'px'; //make sure we have the px defined for the next uses
	
	$(".index_port_item").css("width", $tileWidth); //Make all the portfolio_items have the tile width
	$(".index_port_item.current").css("width", $full_image_width); //The current portfolio_item gets the full size width
	$(".caption").css({ width: $caption_width, opacity: 0 });
	
	
	//This part takes care of the functionality of the slider itself
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if(typeof(isClicked) == 'undefined') { var isClicked = 0; } //If no item has been clicked yet, the variable isClicked doesn't exist, so we create it. 
	
	$(".index_port_item").click(function() { //Whenever an item is clicked :
		isClicked = 1; //Setting isClicked 1, we stop the autsliding from going on
		
		var classClicked = $(this).attr('class'); // Find out all the classes of the clicked item
		
		if(classClicked !== 'index_port_item current') { //If the Item clicked does not contain the .current class in it do the following
			$(".index_port_item.current").removeClass("current").addClass("prev").stop().animate({ width: $tileWidth }, 630);
			$(this).addClass("current").css("width", $tileWidth).stop().animate({ width: $full_image_width }, 730);
			$(".index_port_item.prev").removeClass("prev"); 
		}

	});
	
	if(typeof(isHovered) == 'undefined') { var isHovered = 0; }//If no item has been hovered yet, the variable isHovered doesn't exist, so we create it. 
		
	$(".index_port_item").hover(function() { // Whenever an item is hovered
		isHovered = 1; //Setting isHovered 1, we stop the autsliding from going on
	}, function() {
		isHovered = 0;//Setting isHovered 1, we make the autsliding go on
	});
	
	setInterval(function() {		 
		if(isHovered == 0 && isClicked == 0) { //It only calls the next item IF BOTH isHovered and isClicked are set to 0 
			nextPortfolioItem('730px', $tileWidth);
		}
	}, $time);
}

function nextPortfolioItem($full_image_width, $tile_width) {
	
	$current = $(".index_port_item.current");
	$next = $(".index_port_item.current").next();
	
	if($next.attr('class') == undefined) {
		$next = $(".index_port_item:first");
	} else {
		//Do nothing. The $next element exists
	}
		
	$current.removeClass("current").css("width", $full_image_width).stop().animate({ width: $tile_width }, 630);
	$next.addClass("current").css("width", $tile_width).stop().animate({ width: $full_image_width }, 730);
	
}
