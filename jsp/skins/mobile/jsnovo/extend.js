Ext.override( Ext.data.XmlReader, {
    createAccessor: function() {
        var selectValue = function(key, root, defaultValue){
			if( key == '#' ){
				return root.firstChild.nodeValue;
			}
			if( key.indexOf( '@' ) != -1 ){
				var property = key.split( '@' )[ 1 ];
				key = key.split( '@' )[ 0 ];
			}
			var val;
			if( key.length ){
				var node = Ext.DomQuery.selectNode(key, root);
				if( node && node.firstChild ){
					node = node.firstChild;
				}
			}
			else{
				var node = root;
			}
            if(node){
				if( typeof( node.getAttribute ) != 'undefined' && typeof( property ) != 'undefined' ){
					val = node.getAttribute( property );
				}
				else{
					val = node.nodeValue;
				}
            }
            return Ext.isEmpty(val) ? defaultValue : val;
        };

        return function(key) {
            var fn;
			if (key == this.totalProperty) {
                fn = function(root, defaultValue) {
                    var value = selectValue(key, root, defaultValue);
                    return parseFloat(value);
                };
            }

            else if (key == this.successProperty) {
                fn = function(root, defaultValue) {
                    var value = selectValue(key, root, true);
                    return (value !== false && value !== 'false');
                };
            }

            else {
                fn = function(root, defaultValue) {
                    return selectValue(key, root, defaultValue);
                };
            }

            return fn;
        };
    }(),
});

Ext.override(Ext.Carousel, {
    wrap: false,
    dragstart: function ()
    {
    	alert('ss');
        
    },
    onDragEnd: function (e, t) {
    	//e.gesture.disableLocking = true;

        if (this.checkScrollBounds && !this.outOfScrollBounds) {
            return;
        }

        var previousDelta, deltaOffset;

        if (this.horizontal) {
            deltaOffset = e.deltaX;
            previousDelta = e.previousDeltaX;
        }
        else {
            deltaOffset = e.deltaY;
            previousDelta = e.previousDeltaY;
        }

        if (deltaOffset < 0 && Math.abs(deltaOffset) > 5 && previousDelta <= 0 && this.layout.getNext(this.wrap)) {
            this.next();
        }
        else if (deltaOffset > 0 && Math.abs(deltaOffset) > 5 && previousDelta >= 0 && this.layout.getPrev(this.wrap)) {
            this.prev();
        }
        else {
            this.scrollToCard(this.layout.activeItem);
        }
    },
	next: function () {
        var next = this.layout.getNext(this.wrap);

        if (next) {
            this.customDrag = true;
            this.scrollToCard(next);
        }

        return this;
    },
	DisableSwipe: function()
	{
		alert(paperpanel);
	},
    prev: function () {
        var prev = this.layout.getPrev(this.wrap);

        if (prev) {
            this.customDrag = true;
            this.scrollToCard(prev);
        }

        return this;
    },

    getCardIndexOffset: function (card) {
        var ln = this.items.items.length;
        var currentIndex = this.getActiveIndex();
        var newIndex = this.items.items.indexOf(card);

        var rightOffset = ((ln - currentIndex) + newIndex) % ln;
        var leftOffset = -((currentIndex + (ln - newIndex)) % ln);

        return (Math.abs(leftOffset) <= Math.abs(rightOffset)) ? leftOffset : rightOffset;
    }
});