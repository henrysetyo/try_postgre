CREATE TABLE IF NOT EXISTS public.invoice_input
(
    invoice_id character varying COLLATE pg_catalog."default" NOT NULL,
    pdf_file_name character varying COLLATE pg_catalog."default",
    pdf_file_input bytea,
    email character varying COLLATE pg_catalog."default",
    json_file_input json,
    creation_date date,
    CONSTRAINT invoice_input_pkey PRIMARY KEY (invoice_id),
    CONSTRAINT email FOREIGN KEY (email)
        REFERENCES public."user" (email) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice_input
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.send_to
(
    email character varying COLLATE pg_catalog."default",
    invoice_id character varying COLLATE pg_catalog."default",
    sent_date date,
    CONSTRAINT email FOREIGN KEY (email)
        REFERENCES public."user" (email) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT invoice_id FOREIGN KEY (invoice_id)
        REFERENCES public.invoice_output (invoice_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.send_to
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public."user"
(
    type_user character varying COLLATE pg_catalog."default",
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password_hash character varying COLLATE pg_catalog."default",
    CONSTRAINT user_pkey PRIMARY KEY (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."user"
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS public.invoice_output
(
    invoice_id character varying COLLATE pg_catalog."default" NOT NULL,
    validation_status character varying COLLATE pg_catalog."default",
    creation_date date,
    xml_file_output xml,
    invoice_id_input character varying COLLATE pg_catalog."default",
    CONSTRAINT invoice_output_pkey PRIMARY KEY (invoice_id),
    CONSTRAINT input_invoide_id FOREIGN KEY (invoice_id_input)
        REFERENCES public.invoice_input (invoice_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.invoice_output
    OWNER to postgres;