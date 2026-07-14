


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."delete_user"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
BEGIN
  -- يحذف المستخدم الحالي (المصادَق عليه) فقط من auth.users
  -- SECURITY DEFINER ضروري لأن حذف auth.users يحتاج صلاحيات مرتفعة
  -- لا يقدر مستخدم عادي يملكها مباشرة
  DELETE FROM auth.users WHERE id = auth.uid();
END;
$$;


ALTER FUNCTION "public"."delete_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."rls_auto_enable"() RETURNS "event_trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'pg_catalog'
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN
    SELECT *
    FROM pg_event_trigger_ddl_commands()
    WHERE command_tag IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
      AND object_type IN ('table','partitioned table')
  LOOP
     IF cmd.schema_name IS NOT NULL AND cmd.schema_name IN ('public') AND cmd.schema_name NOT IN ('pg_catalog','information_schema') AND cmd.schema_name NOT LIKE 'pg_toast%' AND cmd.schema_name NOT LIKE 'pg_temp%' THEN
      BEGIN
        EXECUTE format('alter table if exists %s enable row level security', cmd.object_identity);
        RAISE LOG 'rls_auto_enable: enabled RLS on %', cmd.object_identity;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE LOG 'rls_auto_enable: failed to enable RLS on %', cmd.object_identity;
      END;
     ELSE
        RAISE LOG 'rls_auto_enable: skip % (either system schema or not in enforced list: %.)', cmd.object_identity, cmd.schema_name;
     END IF;
  END LOOP;
END;
$$;


ALTER FUNCTION "public"."rls_auto_enable"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."adwaa_al_bayan_pages" (
    "page_number" integer NOT NULL,
    "shamela_url" "text" NOT NULL,
    "page_title" "text",
    "page_text" "text" NOT NULL
);


ALTER TABLE "public"."adwaa_al_bayan_pages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."adwaa_al_bayan_toc" (
    "surah_id" smallint NOT NULL,
    "ayah_number" smallint NOT NULL,
    "start_page" integer NOT NULL
);


ALTER TABLE "public"."adwaa_al_bayan_toc" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."asbab_al_nuzul" (
    "id" bigint NOT NULL,
    "ayah_id" bigint NOT NULL,
    "language" "text" DEFAULT 'ar'::"text" NOT NULL,
    "event_text" "text" DEFAULT ''::"text" NOT NULL,
    "confidence" "text" DEFAULT 'strong'::"text",
    "source_book" "text" DEFAULT ''::"text" NOT NULL
);


ALTER TABLE "public"."asbab_al_nuzul" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."asbab_al_nuzul_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."asbab_al_nuzul_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."asbab_al_nuzul_id_seq" OWNED BY "public"."asbab_al_nuzul"."id";



CREATE TABLE IF NOT EXISTS "public"."ayah_hadiths" (
    "id" bigint NOT NULL,
    "ayah_id" bigint,
    "hadith_id" bigint,
    "relevance" "text" DEFAULT 'related'::"text"
);


ALTER TABLE "public"."ayah_hadiths" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."ayah_hadiths_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."ayah_hadiths_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."ayah_hadiths_id_seq" OWNED BY "public"."ayah_hadiths"."id";



CREATE TABLE IF NOT EXISTS "public"."ayahs" (
    "id" bigint NOT NULL,
    "surah_id" smallint NOT NULL,
    "ayah_number" smallint NOT NULL,
    "text_uthmani" "text" DEFAULT ''::"text" NOT NULL
);


ALTER TABLE "public"."ayahs" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."ayahs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."ayahs_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."ayahs_id_seq" OWNED BY "public"."ayahs"."id";



CREATE TABLE IF NOT EXISTS "public"."children_stories" (
    "id" bigint NOT NULL,
    "title_ar" "text" NOT NULL,
    "title_en" "text",
    "content_ar" "text",
    "moral_ar" "text",
    "age_range" "text" DEFAULT '6-12'::"text",
    "category" "text",
    "emoji" "text",
    "color" "text",
    "order_index" integer DEFAULT 0,
    "is_published" boolean DEFAULT false
);


ALTER TABLE "public"."children_stories" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."children_stories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."children_stories_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."children_stories_id_seq" OWNED BY "public"."children_stories"."id";



CREATE TABLE IF NOT EXISTS "public"."hadith_books" (
    "id" "text" NOT NULL,
    "name_ar" "text" NOT NULL,
    "name_en" "text",
    "total" integer DEFAULT 0
);


ALTER TABLE "public"."hadith_books" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."hadith_categories" (
    "id" integer NOT NULL,
    "title_ar" "text" NOT NULL,
    "hadeeths_count" integer DEFAULT 0,
    "parent_id" integer
);


ALTER TABLE "public"."hadith_categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."hadith_category_links" (
    "hadith_id" bigint NOT NULL,
    "category_id" integer NOT NULL
);


ALTER TABLE "public"."hadith_category_links" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."hadiths" (
    "id" bigint NOT NULL,
    "book_id" "text",
    "hadith_number" integer,
    "text_ar" "text" NOT NULL,
    "narrator" "text",
    "grade" "text",
    "title" "text",
    "explanation" "text",
    "category_id" integer,
    "source" "text" DEFAULT 'HadeethEnc.com (islamhouse-dev)'::"text"
);


ALTER TABLE "public"."hadiths" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."hadiths_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."hadiths_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."hadiths_id_seq" OWNED BY "public"."hadiths"."id";



CREATE TABLE IF NOT EXISTS "public"."stories" (
    "id" bigint NOT NULL,
    "category" "text" NOT NULL,
    "title_ar" "text" NOT NULL,
    "title_en" "text",
    "summary_ar" "text",
    "content_ar" "text",
    "person_name" "text",
    "period" "text",
    "lessons" "text"[],
    "tags" "text"[],
    "order_index" integer DEFAULT 0,
    "is_published" boolean DEFAULT false
);


ALTER TABLE "public"."stories" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."stories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."stories_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."stories_id_seq" OWNED BY "public"."stories"."id";



CREATE TABLE IF NOT EXISTS "public"."surahs" (
    "id" smallint NOT NULL,
    "name_arabic" "text" DEFAULT ''::"text" NOT NULL,
    "name_english" "text",
    "ayah_count" smallint DEFAULT 0 NOT NULL,
    "revelation_type" "text"
);


ALTER TABLE "public"."surahs" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tafsir" (
    "id" bigint NOT NULL,
    "ayah_id" bigint NOT NULL,
    "source_id" "text" NOT NULL,
    "text" "text" DEFAULT ''::"text" NOT NULL
);


ALTER TABLE "public"."tafsir" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."tafsir_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."tafsir_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."tafsir_id_seq" OWNED BY "public"."tafsir"."id";



CREATE TABLE IF NOT EXISTS "public"."tafsir_sources" (
    "id" "text" NOT NULL,
    "scholar" "text" DEFAULT ''::"text" NOT NULL,
    "book_title" "text" DEFAULT ''::"text" NOT NULL,
    "language" "text" DEFAULT 'ar'::"text" NOT NULL,
    "is_active" boolean DEFAULT true
);


ALTER TABLE "public"."tafsir_sources" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."verse_hadith_relations" (
    "id" bigint NOT NULL,
    "ayah_id" bigint NOT NULL,
    "citation_type" "text" NOT NULL,
    "quoted_text" "text" NOT NULL,
    "full_paragraph" "text" NOT NULL,
    "source_reference" "text" NOT NULL,
    "source_book" "text" DEFAULT 'أضواء البيان في إيضاح القرآن بالقرآن'::"text" NOT NULL,
    "source_author" "text" DEFAULT 'محمد الأمين الشنقيطي'::"text" NOT NULL,
    "shamela_url" "text" NOT NULL,
    "shamela_page" integer NOT NULL,
    "reviewed" boolean DEFAULT false NOT NULL,
    "reviewed_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "verse_hadith_relations_citation_type_check" CHECK (("citation_type" = ANY (ARRAY['authentic_hadith'::"text", 'israiliyyat'::"text"])))
);


ALTER TABLE "public"."verse_hadith_relations" OWNER TO "postgres";


ALTER TABLE "public"."verse_hadith_relations" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."verse_hadith_relations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."word_meanings" (
    "id" bigint NOT NULL,
    "ayah_id" bigint NOT NULL,
    "word_position" smallint NOT NULL,
    "word_text" "text",
    "meaning_ar" "text" DEFAULT ''::"text" NOT NULL,
    "morphology" "text",
    "confidence" "text" DEFAULT 'canonical'::"text",
    "data_source" "text" DEFAULT 'tafsir_mcp'::"text"
);


ALTER TABLE "public"."word_meanings" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."word_meanings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."word_meanings_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."word_meanings_id_seq" OWNED BY "public"."word_meanings"."id";



ALTER TABLE ONLY "public"."asbab_al_nuzul" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."asbab_al_nuzul_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."ayah_hadiths" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."ayah_hadiths_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."ayahs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."ayahs_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."children_stories" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."children_stories_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."hadiths" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."hadiths_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."stories" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."stories_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."tafsir" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tafsir_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."word_meanings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."word_meanings_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."adwaa_al_bayan_pages"
    ADD CONSTRAINT "adwaa_al_bayan_pages_pkey" PRIMARY KEY ("page_number");



ALTER TABLE ONLY "public"."adwaa_al_bayan_toc"
    ADD CONSTRAINT "adwaa_al_bayan_toc_pkey" PRIMARY KEY ("surah_id", "ayah_number");



ALTER TABLE ONLY "public"."asbab_al_nuzul"
    ADD CONSTRAINT "asbab_al_nuzul_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."ayah_hadiths"
    ADD CONSTRAINT "ayah_hadiths_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."ayahs"
    ADD CONSTRAINT "ayahs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."ayahs"
    ADD CONSTRAINT "ayahs_surah_id_ayah_number_key" UNIQUE ("surah_id", "ayah_number");



ALTER TABLE ONLY "public"."children_stories"
    ADD CONSTRAINT "children_stories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."hadith_books"
    ADD CONSTRAINT "hadith_books_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."hadith_categories"
    ADD CONSTRAINT "hadith_categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."hadith_category_links"
    ADD CONSTRAINT "hadith_category_links_pkey" PRIMARY KEY ("hadith_id", "category_id");



ALTER TABLE ONLY "public"."hadiths"
    ADD CONSTRAINT "hadiths_book_id_hadith_number_key" UNIQUE ("book_id", "hadith_number");



ALTER TABLE ONLY "public"."hadiths"
    ADD CONSTRAINT "hadiths_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."stories"
    ADD CONSTRAINT "stories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."surahs"
    ADD CONSTRAINT "surahs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tafsir"
    ADD CONSTRAINT "tafsir_ayah_id_source_id_key" UNIQUE ("ayah_id", "source_id");



ALTER TABLE ONLY "public"."tafsir"
    ADD CONSTRAINT "tafsir_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tafsir_sources"
    ADD CONSTRAINT "tafsir_sources_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."verse_hadith_relations"
    ADD CONSTRAINT "verse_hadith_relations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."word_meanings"
    ADD CONSTRAINT "word_meanings_ayah_id_word_position_key" UNIQUE ("ayah_id", "word_position");



ALTER TABLE ONLY "public"."word_meanings"
    ADD CONSTRAINT "word_meanings_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_verse_hadith_relations_ayah_id" ON "public"."verse_hadith_relations" USING "btree" ("ayah_id");



ALTER TABLE ONLY "public"."asbab_al_nuzul"
    ADD CONSTRAINT "asbab_al_nuzul_ayah_id_fkey" FOREIGN KEY ("ayah_id") REFERENCES "public"."ayahs"("id");



ALTER TABLE ONLY "public"."ayah_hadiths"
    ADD CONSTRAINT "ayah_hadiths_ayah_id_fkey" FOREIGN KEY ("ayah_id") REFERENCES "public"."ayahs"("id");



ALTER TABLE ONLY "public"."ayah_hadiths"
    ADD CONSTRAINT "ayah_hadiths_hadith_id_fkey" FOREIGN KEY ("hadith_id") REFERENCES "public"."hadiths"("id");



ALTER TABLE ONLY "public"."ayahs"
    ADD CONSTRAINT "ayahs_surah_id_fkey" FOREIGN KEY ("surah_id") REFERENCES "public"."surahs"("id");



ALTER TABLE ONLY "public"."hadith_category_links"
    ADD CONSTRAINT "hadith_category_links_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."hadith_categories"("id");



ALTER TABLE ONLY "public"."hadith_category_links"
    ADD CONSTRAINT "hadith_category_links_hadith_id_fkey" FOREIGN KEY ("hadith_id") REFERENCES "public"."hadiths"("id");



ALTER TABLE ONLY "public"."hadiths"
    ADD CONSTRAINT "hadiths_book_id_fkey" FOREIGN KEY ("book_id") REFERENCES "public"."hadith_books"("id");



ALTER TABLE ONLY "public"."tafsir"
    ADD CONSTRAINT "tafsir_ayah_id_fkey" FOREIGN KEY ("ayah_id") REFERENCES "public"."ayahs"("id");



ALTER TABLE ONLY "public"."tafsir"
    ADD CONSTRAINT "tafsir_source_id_fkey" FOREIGN KEY ("source_id") REFERENCES "public"."tafsir_sources"("id");



ALTER TABLE ONLY "public"."verse_hadith_relations"
    ADD CONSTRAINT "verse_hadith_relations_ayah_id_fkey" FOREIGN KEY ("ayah_id") REFERENCES "public"."ayahs"("id");



ALTER TABLE ONLY "public"."word_meanings"
    ADD CONSTRAINT "word_meanings_ayah_id_fkey" FOREIGN KEY ("ayah_id") REFERENCES "public"."ayahs"("id");



CREATE POLICY "Public read access" ON "public"."asbab_al_nuzul" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."ayah_hadiths" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."ayahs" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."children_stories" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."hadith_categories" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."hadith_category_links" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."hadiths" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."stories" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."tafsir" FOR SELECT USING (true);



CREATE POLICY "Public read access" ON "public"."word_meanings" FOR SELECT USING (true);



ALTER TABLE "public"."adwaa_al_bayan_pages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."adwaa_al_bayan_toc" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."asbab_al_nuzul" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."ayah_hadiths" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."ayahs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."children_stories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."hadith_categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."hadith_category_links" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."hadiths" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."stories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tafsir" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."verse_hadith_relations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."word_meanings" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "قراءة عامة لكل الصفحات" ON "public"."adwaa_al_bayan_pages" FOR SELECT USING (true);



CREATE POLICY "قراءة عامة للفهرس" ON "public"."adwaa_al_bayan_toc" FOR SELECT USING (true);



CREATE POLICY "قراءة عامة للمُراجَع فقط" ON "public"."verse_hadith_relations" FOR SELECT USING (("reviewed" = true));





ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";






















































































































































GRANT ALL ON FUNCTION "public"."delete_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."delete_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."delete_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "anon";
GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."rls_auto_enable"() TO "service_role";


















GRANT ALL ON TABLE "public"."adwaa_al_bayan_pages" TO "anon";
GRANT ALL ON TABLE "public"."adwaa_al_bayan_pages" TO "authenticated";
GRANT ALL ON TABLE "public"."adwaa_al_bayan_pages" TO "service_role";



GRANT ALL ON TABLE "public"."adwaa_al_bayan_toc" TO "anon";
GRANT ALL ON TABLE "public"."adwaa_al_bayan_toc" TO "authenticated";
GRANT ALL ON TABLE "public"."adwaa_al_bayan_toc" TO "service_role";



GRANT ALL ON TABLE "public"."asbab_al_nuzul" TO "anon";
GRANT ALL ON TABLE "public"."asbab_al_nuzul" TO "authenticated";
GRANT ALL ON TABLE "public"."asbab_al_nuzul" TO "service_role";



GRANT ALL ON SEQUENCE "public"."asbab_al_nuzul_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."asbab_al_nuzul_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."asbab_al_nuzul_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."ayah_hadiths" TO "anon";
GRANT ALL ON TABLE "public"."ayah_hadiths" TO "authenticated";
GRANT ALL ON TABLE "public"."ayah_hadiths" TO "service_role";



GRANT ALL ON SEQUENCE "public"."ayah_hadiths_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."ayah_hadiths_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."ayah_hadiths_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."ayahs" TO "anon";
GRANT ALL ON TABLE "public"."ayahs" TO "authenticated";
GRANT ALL ON TABLE "public"."ayahs" TO "service_role";



GRANT ALL ON SEQUENCE "public"."ayahs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."ayahs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."ayahs_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."children_stories" TO "anon";
GRANT ALL ON TABLE "public"."children_stories" TO "authenticated";
GRANT ALL ON TABLE "public"."children_stories" TO "service_role";



GRANT ALL ON SEQUENCE "public"."children_stories_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."children_stories_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."children_stories_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."hadith_books" TO "anon";
GRANT ALL ON TABLE "public"."hadith_books" TO "authenticated";
GRANT ALL ON TABLE "public"."hadith_books" TO "service_role";



GRANT ALL ON TABLE "public"."hadith_categories" TO "anon";
GRANT ALL ON TABLE "public"."hadith_categories" TO "authenticated";
GRANT ALL ON TABLE "public"."hadith_categories" TO "service_role";



GRANT ALL ON TABLE "public"."hadith_category_links" TO "anon";
GRANT ALL ON TABLE "public"."hadith_category_links" TO "authenticated";
GRANT ALL ON TABLE "public"."hadith_category_links" TO "service_role";



GRANT ALL ON TABLE "public"."hadiths" TO "anon";
GRANT ALL ON TABLE "public"."hadiths" TO "authenticated";
GRANT ALL ON TABLE "public"."hadiths" TO "service_role";



GRANT ALL ON SEQUENCE "public"."hadiths_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."hadiths_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."hadiths_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."stories" TO "anon";
GRANT ALL ON TABLE "public"."stories" TO "authenticated";
GRANT ALL ON TABLE "public"."stories" TO "service_role";



GRANT ALL ON SEQUENCE "public"."stories_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."stories_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."stories_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."surahs" TO "anon";
GRANT ALL ON TABLE "public"."surahs" TO "authenticated";
GRANT ALL ON TABLE "public"."surahs" TO "service_role";



GRANT ALL ON TABLE "public"."tafsir" TO "anon";
GRANT ALL ON TABLE "public"."tafsir" TO "authenticated";
GRANT ALL ON TABLE "public"."tafsir" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tafsir_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tafsir_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tafsir_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tafsir_sources" TO "anon";
GRANT ALL ON TABLE "public"."tafsir_sources" TO "authenticated";
GRANT ALL ON TABLE "public"."tafsir_sources" TO "service_role";



GRANT ALL ON TABLE "public"."verse_hadith_relations" TO "anon";
GRANT ALL ON TABLE "public"."verse_hadith_relations" TO "authenticated";
GRANT ALL ON TABLE "public"."verse_hadith_relations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."verse_hadith_relations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."verse_hadith_relations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."verse_hadith_relations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."word_meanings" TO "anon";
GRANT ALL ON TABLE "public"."word_meanings" TO "authenticated";
GRANT ALL ON TABLE "public"."word_meanings" TO "service_role";



GRANT ALL ON SEQUENCE "public"."word_meanings_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."word_meanings_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."word_meanings_id_seq" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";



































