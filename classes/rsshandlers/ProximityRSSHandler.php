<?php


class ProximityRSSHandler extends OCRSSHandlerBase
{

  protected $townCode = false;
  protected $townName = '';
  protected $townLat  = false;
  protected $townLon  = false;


  function __construct( $townCode )
  {
    $this->townCode = $townCode;

    $this->fetchTown();
  }

  function getNodes()
  {
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
      $filters []= '(attr_condivisione_comuni_b:true AND fq:{!geofilt pt='.$this->townLon.','.$this->townLat.' sfield=subattr_geo___coordinates____gpt d=5})';
    }

    return array(implode(' OR ', $filters));
  }

  protected function fetchTown()
  {
    if (  $this->townCode )
    {
      $searchParameters = array(
        'limit' => '1',
        'class_id' => array('comune'),
        'filter' => array('attr_istat_s:' . $this->townCode),
      );

      $searchResult = eZFunctionHandler::execute( 'ezfind', 'search', $searchParameters );
      if ($searchResult['SearchCount'] > 0) {

        /** @var eZContentObject $object */
        $object = $searchResult['SearchResult'][0]->ContentObject;

        $this->townName = $object->Name;

        $dataMap = $object->dataMap();

        /*

        1|#46.066423|#11.12576|#Trento, Territorio Val d'Adige, TN, Trentino-Alto Adige, Italia
        eZGmapLocation Object
        (
            [PersistentDataDirty] =>
            [contentobject_attribute_id] => 168188
            [contentobject_version] => 2
            [latitude] => 46.066423
            [longitude] => 11.12576
            [street] => Trento, Territorio Val d'Adige, TN, Trentino-Alto Adige, Italia
        )

         */

        if ($dataMap['geo']->hasContent()) {
          $this->townLat = $dataMap['geo']->content()->latitude;
          $this->townLon = $dataMap['geo']->content()->longitude;
        }
      }
    }
  }


  function getFeedTitle()
  {
    return 'News per il comune di ' . $this->townName;
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
