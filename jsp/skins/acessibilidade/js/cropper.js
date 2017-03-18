function loadCropper(){

var CropImageManager = {
            curCrop: null,
            init: function() {
                this.attachCropper();
            },
            onChange: function( e ) {
                var vals = $F( Event.element( e ) ).split('|');
                this.setImage( vals[0], vals[1], vals[2] );
            },
            setImage: function( imgSrc, w, h ) {
                $( 'testImage' ).src = imgSrc;
                $( 'testImage' ).width = w;
                $( 'testImage' ).height = h;
                this.attachCropper();
            },
            attachCropper: function() {
                if( this.curCrop == null ) this.curCrop = new Cropper.Img( 'testImage', { onEndCrop: onEndCrop } );
                else this.curCrop.reset();
            },
            removeCropper: function() {
                if( this.curCrop != null ) {
                    this.curCrop.remove();
                }
            },
            resetCropper: function() {
                this.attachCropper();
            }
        };
}
        function onEndCrop( coords, dimensions ) {
            $('coord').value = coords.x1+","+coords.y1+"-"+dimensions.width+","+dimensions.height;
        }
        function loadExample( type ) {
            switch( type ) {
                case( 'minWidth' ) :
                    new Cropper.Img( 'testImage', { minWidth: 220, onEndCrop: onEndCrop } );
                    break;
                case( 'minHeight' ) :
                    new Cropper.Img( 'testImage', { minHeight: 120, onEndCrop: onEndCrop } );
                    break;
                case( 'minDimensions' ) :
                    new Cropper.Img( 'testImage', { minWidth: 220, minHeight: 120, onEndCrop: onEndCrop } );
                    break;
                case( 'ratioFourThree' ) :
                    new Cropper.Img( 'testImage', { ratioDim: { x: 220, y: 165 }, displayOnInit: true, onEndCrop: onEndCrop } );
                    break;
                case( 'ratioSixteenNine' ) :
                    new Cropper.Img( 'testImage', { ratioDim: { x: 220, y: 124 }, displayOnInit: true, onEndCrop: onEndCrop } );
                    break;
                case( 'preview' ) :
                    new Cropper.ImgWithPreview( 'testImage', { previewWrap: 'previewWrap', minWidth: 120, minHeight: 120, ratioDim: { x: 120, y: 120 }, onEndCrop: onEndCrop } );
                    break;
                case( 'dynamic' ) :
                    CropImageManager.init();
                    Event.observe( $('removeCropper'), 'click', CropImageManager.removeCropper.bindAsEventListener( CropImageManager ), false );
                    Event.observe( $('resetCropper'), 'click', CropImageManager.resetCropper.bindAsEventListener( CropImageManager ), false );
                    Event.observe( $('imageChoice'), 'change', CropImageManager.onChange.bindAsEventListener( CropImageManager ), false );
                    break;
                case( 'basic' ) :
                default :
                    new Cropper.Img( 'testImage', { onEndCrop: onEndCrop } );
            }
        }
