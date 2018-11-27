<?php


class ProximityRSSHandler extends OCRSSHandlerBase
{

  protected $townCode = false;
  protected $townLat  = false;
  protected $townLon  = false;


  function __construct( $townCode )
  {
    $this->townCode = $townCode;
  }

  function getNodes()
  {
    if ( empty( $this->townCode ) )
    {
      throw new Exception( "Code not present" );
    }


    //(raw[!geofilt pt=11.12576,46.066423 sfield=subattr_geo___coordinates____gpt d=5]) and (raw[subattr_geo___longitude____f] = '*' and raw[subattr_geo___latitude____f] = '*')
    //41.9101776,12.4659587
    $searchParameters = array(
      'limit' => eZINI::instance( 'ocrss.ini' )->variable( 'FilterSettings', 'limit' ),
      'class_id' => array('news'),
      'filter' => $this->buildSearchFilter(), //array('fq:{!geofilt pt=12.4659587,41.9101776 sfield=subattr_geo___coordinates____gpt d=5}'),
      'sort_by' => array(
        'attr_publish_date_dt' => 'desc',
        'published' => 'desc'
      )
    );

    $searchResult = eZFunctionHandler::execute( 'ezfind', 'search', $searchParameters );
    return $searchResult['SearchResult'];

  }


  protected function buildSearchFilter()
  {
    $filters = array();
    $filters []= '(attr_diffondi_su_tutti_i_comuni_b:true)';

    // Verificare che sia
    if ( $this->townLat && $this->townLon ) {
      $filters []= '(attr_condivisione_comuni_b:true AND fq:{!geofilt pt=12.4659587,41.9101776 sfield=subattr_geo___coordinates____gpt d=5}';
    }

    return array(implode(' OR ', $filters));
  }


  function getFeedTitle()
  {
    // TODO: Implement getFeedTitle() method.
  }

  function getFeedAccessUrl()
  {
    // TODO: Implement getFeedAccessUrl() method.
  }

  function getFeedDescription()
  {
    // TODO: Implement getFeedDescription() method.
  }

  function getFeedImageUrl()
  {
    // TODO: Implement getFeedImageUrl() method.
  }

  function cacheKey()
  {
    // TODO: Implement cacheKey() method.
  }

}
