# frozen_string_literal: true

class RemoveAssetsTable < ActiveRecord::Migration[5.2]
  def up
    remove_column :creatives, :small_image_asset_id
    remove_column :creatives, :large_image_asset_id
    remove_column :creatives, :wide_image_asset_id
    drop_table :assets
  end

  def down
    add_column :creatives, :small_image_asset_id, :uuid
    add_column :creatives, :large_image_asset_id, :uuid
    add_column :creatives, :wide_image_asset_id, :uuid
    execute <<~SQL
      CREATE TABLE public.assets (
          user_id uuid,
          id uuid NOT NULL,
          name character varying(255) NOT NULL,
          image_object character varying(255) NOT NULL,
          image_bucket character varying(255) NOT NULL,
          inserted_at timestamp without time zone NOT NULL,
          updated_at timestamp without time zone NOT NULL,
          height integer,
          width integer
      );

      ALTER TABLE ONLY public.assets ADD CONSTRAINT assets_pkey PRIMARY KEY (id);
      CREATE INDEX assets_user_id_index ON public.assets USING btree (user_id);
      ALTER TABLE ONLY public.assets ADD CONSTRAINT assets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);

      ALTER TABLE ONLY public.creatives
          ADD CONSTRAINT creatives_large_image_asset_id_fkey FOREIGN KEY (large_image_asset_id) REFERENCES public.assets(id);

      ALTER TABLE ONLY public.creatives
          ADD CONSTRAINT creatives_small_image_asset_id_fkey FOREIGN KEY (small_image_asset_id) REFERENCES public.assets(id);

      ALTER TABLE ONLY public.creatives
          ADD CONSTRAINT creatives_wide_image_asset_id_fkey FOREIGN KEY (wide_image_asset_id) REFERENCES public.assets(id);
    SQL
  end
end
