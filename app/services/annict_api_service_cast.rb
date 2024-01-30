class AnnictApiServiceCast
  def initialize
    @base_url = "https://api.annict.com/v1/casts"
    @access_token = ENV["ANNICT_ACCESS_TOKEN"]
  end

  def import_cast_data(works)
    # ユニークなwork_idを保持する配列
    unique_work_ids = works.map { |work| work.annict_id }

    unique_work_ids.each do |work_annict_id|
      puts work_annict_id
      response = Faraday.get("#{@base_url}", {
        fields: 'id,sort_number,work.id,character.name,character.name_kana,person.id',
        per_page: 50,
        filter_work_id: work_annict_id, # work_annict_idでフィルタリング
        access_token: @access_token
      })
      data = JSON.parse(response.body)
      puts data
      next unless data["casts"].is_a?(Array)
      
      create_cast_records(data["casts"], work_annict_id)
    end
  end
  
  private

  # API結果をCastテーブルへ登録する関数
  def create_cast_records(casts, work_annict_id)
    casts.each do |cast|
      work = Work.find_by(annict_id: work_annict_id)
      #if cast["sort_number"] <= 10 && cast["work"]["id"].to_i == work_annict_id
        # Cast モデルのレコードを検索し、存在しない場合は初期化
      cast_record = Cast.find_or_initialize_by(cast_id: cast["id"])
      # レコードの属性を更新
      unless cast_record.update(
        work_id: work["id"],
        cast_id: cast["id"],
        sort_number: cast["sort_number"],
        person_id: cast["person"]["id"],
        character_name: cast["character"]["name"],
        character_name_kana: cast["character"]["name_kana"]
      )
      puts "Update failed: #{cast_record.errors.full_messages.join(", ")}"
      end
    end
  
  end
end