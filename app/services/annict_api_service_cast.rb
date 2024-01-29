class AnnictApiServiceCast
  def initialize
    @base_url = "https://api.annict.com/v1/casts"
    @access_token = ENV["ANNICT_ACCESS_TOKEN"]
  end

  def import_cast_data
    
    response = Faraday.get("#{@base_url}", {
      fields: 'id,sort_number,work,character,person',
      per_page: 50,
      access_token: @access_token
    })
    data = JSON.parse(response.body)
    puts data
    return unless data["casts"].is_a?(Array)
    
    create_cast_records(data["casts"])
    
  end
  
  private

  # API結果をCastテーブルへ登録する関数
  def create_cast_records(casts)
    casts.each do |cast|
      if cast["sort_number"] =< 10
      # Cast モデルのレコードを検索し、存在しない場合は初期化
      cast_record = Cast.find_or_initialize_by(cast_id: cast["id"])
      # レコードの属性を更新
      cast_record.update(
        cast_id: cast["id"],
        sort_number: cast["sort_number"],
        work_id: cast["work"]["id"],
        person_id: cast["person"]["id"],
        character_name: cast["character"]["name"],
        character_name_kana: cast["character"]["name_kana"]
        )
    end
  end
end