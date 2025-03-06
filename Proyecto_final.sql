{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "provenance": [],
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/titanioco/Proyecto-Final-DB/blob/main/Proyecto_final.sql\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "execution_count": null,
      "metadata": {
        "id": "0OyEY0Ea_wvO",
        "outputId": "992a80cc-c46d-4950-a8a2-1ab43df44300",
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 106
        }
      },
      "outputs": [
        {
          "output_type": "error",
          "ename": "SyntaxError",
          "evalue": "invalid syntax (<ipython-input-1-474172ff6ef7>, line 1)",
          "traceback": [
            "\u001b[0;36m  File \u001b[0;32m\"<ipython-input-1-474172ff6ef7>\"\u001b[0;36m, line \u001b[0;32m1\u001b[0m\n\u001b[0;31m    -- Tabla de Entidades (Entidad contratante), normalizada a partir de ID_ENTIDAD y nombre de entidad.\u001b[0m\n\u001b[0m             ^\u001b[0m\n\u001b[0;31mSyntaxError\u001b[0m\u001b[0;31m:\u001b[0m invalid syntax\n"
          ]
        }
      ],
      "source": [
        "-- Tabla de Entidades (Entidad contratante), normalizada a partir de ID_ENTIDAD y nombre de entidad.\n",
        "CREATE TABLE entidad (\n",
        "    id_entidad      INT PRIMARY KEY AUTO_INCREMENT,\n",
        "    nombre_entidad  VARCHAR(255) NOT NULL,\n",
        "    caracter_entidad VARCHAR(20),            -- Ej: 'Pública', 'Privada', 'Mixta'\n",
        "    -- Otros posibles campos de entidad (opcionalmente contactos generales, etc.)\n",
        "    INDEX idx_nombre_entidad (nombre_entidad)\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla principal Base Maestra de proyectos (datos consolidados y aprobados de cada proyecto)\n",
        "CREATE TABLE base_maestra (\n",
        "    id_cid              INT PRIMARY KEY AUTO_INCREMENT,   -- Código interno único de proyecto (CID)\n",
        "    id_entidad          INT NOT NULL,\n",
        "    id_quipu            VARCHAR(50),    -- Código QUIPU (se llenará al aprobar contrato)\n",
        "    id_hermes           VARCHAR(50),    -- Código HERMES (se llenará al aprobar contrato)\n",
        "    -- Campos de identificación y generales (no duplicados en otras tablas):\n",
        "    interfic            TINYINT(1),     -- Indicador InterFic (0/1)\n",
        "    ati                 TINYINT(1),     -- Indicador ATI (0/1)\n",
        "    facultad_lider      VARCHAR(100),   -- Nombre de la facultad líder\n",
        "    objeto              TEXT,           -- Objeto/Descripción del proyecto\n",
        "    saber_cid           VARCHAR(100),   -- Área de saber CID (categoría de conocimiento)\n",
        "    modalidad_extension VARCHAR(100),   -- Modalidad de Extensión (ej. Educación continua, Consultoría, etc.)\n",
        "    valor_contrato_fce  DECIMAL(15,2),  -- Valor del contrato asignado a FCE (final aprobado)\n",
        "    valor_contrato_marco_final DECIMAL(15,2),  -- Valor final del Contrato Marco (aprobado tras modificaciones)\n",
        "    otras_transferencias_est DECIMAL(15,2),    -- Otras transferencias (estimado) - mantenido en base\n",
        "    transferencia_fce_est   DECIMAL(15,2),     -- Transferencia FCE (estimado) - mantenido en base\n",
        "    director            VARCHAR(100),   -- Nombre del director del proyecto\n",
        "    tipo_direccion      VARCHAR(50),    -- Tipo de dirección (ej. Interna/Externa)\n",
        "    -- Campos de estado de Propuesta (consolidado en base):\n",
        "    estado_propuesta    VARCHAR(100),   -- Estado de la propuesta (ej. \"Adjudicada\", \"Presentada y no adjudicada\", etc.)\n",
        "    fecha_presentacion_cf_av DATE,      -- Fecha presentación en Consejo de Facultad (acuerdo de voluntades)\n",
        "    acta_presentacion_cf_av   VARCHAR(50),    -- Acta de presentación en Consejo de Facultad (acuerdo de voluntades)\n",
        "    estado_firma        VARCHAR(50),    -- Estado de firma del contrato (ej. \"Firmado\", \"Pendiente\")\n",
        "    id_acuerdo_voluntades VARCHAR(50),  -- ID del Acuerdo de Voluntades\n",
        "    fecha_firma_acuerdo_vol DATE,       -- Fecha de firma del Acuerdo de Voluntades\n",
        "    fecha_firma_contrato DATE,          -- Fecha de firma del contrato marco\n",
        "    id_resolucion_inicio   VARCHAR(50), -- Número/ID de la resolución de inicio de ejecución\n",
        "    fecha_inicio        DATE,           -- Fecha de inicio de ejecución (real)\n",
        "    fecha_finalizacion_pror DATE,       -- Fecha de finalización con prórrogas (real, final)\n",
        "    modificaciones      INT,            -- Cantidad de modificaciones al contrato\n",
        "    tipo_modificaciones VARCHAR(255),   -- Tipo(s) de modificaciones realizadas\n",
        "    valor_direccion     DECIMAL(15,2),  -- Valor por dirección (honorarios del director)\n",
        "    tipo_vinculacion_director VARCHAR(50), -- Tipo de vinculación del director (ej. planta, contratista)\n",
        "    presupuesto_comprometido DECIMAL(15,2), -- Presupuesto comprometido (valor total comprometido)\n",
        "    porc_presupuesto_comprometido DECIMAL(7,2), -- % del presupuesto comprometido\n",
        "    valor_ejecutado     DECIMAL(15,2),  -- Valor ejecutado (gasto realizado)\n",
        "    porc_facturacion    DECIMAL(7,2),   -- % Facturación alcanzada (porcentaje facturado vs comprometido)\n",
        "    facturacion         DECIMAL(15,2),  -- Total facturado (ingresos facturados)\n",
        "    porc_ingresos       DECIMAL(7,2),   -- % Ingresos recibidos vs comprometido\n",
        "    ingresos            DECIMAL(15,2),  -- Total ingresado/pagado\n",
        "    estado_ejecucion    VARCHAR(50),    -- Estado de ejecución (ej. \"En ejecución\", \"Finalizado\")\n",
        "    excedentes          DECIMAL(15,2),  -- Excedentes (fondos no ejecutados, devueltos)\n",
        "    porc_participacion_fce DECIMAL(7,2), -- % Participación FCE (porcentaje de participación financiera FCE)\n",
        "    fecha_liquidacion   DATE,           -- Fecha de inicio de liquidación\n",
        "    fase_liquidacion    VARCHAR(50),    -- Fase de liquidación (ej. \"En liquidación\", \"Liquidado\")\n",
        "    -- Clave foránea a Entidad\n",
        "    FOREIGN KEY (id_entidad) REFERENCES entidad(id_entidad)\n",
        "        ON UPDATE CASCADE ON DELETE RESTRICT,\n",
        "    -- Índices para consultas rápidas:\n",
        "    UNIQUE KEY uq_quipu (id_quipu),\n",
        "    UNIQUE KEY uq_hermes (id_hermes),\n",
        "    INDEX idx_entidad (id_entidad),\n",
        "    INDEX idx_estado_prop (estado_propuesta),\n",
        "    INDEX idx_estado_ejec (estado_ejecucion)\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla de Propuestas (etapa de propuesta/cotización).\n",
        "-- Incluye campos específicos de la etapa de propuestas que no están en Base Maestra.\n",
        "CREATE TABLE propuestas (\n",
        "    id_cid              INT PRIMARY KEY,   -- usa el mismo ID de Base Maestra (1 a 1)\n",
        "    tipologia           VARCHAR(50),       -- Tipología de propuesta (ej. Propuesta, Cotización, Invitación)\n",
        "    origen_proceso      VARCHAR(100),      -- Origen del proceso (ej. Concurso de méritos, Invitación directa, etc.)\n",
        "    num_proceso         VARCHAR(50),       -- Número de proceso (identificador del proceso licitatorio)\n",
        "    caracter_entidad    VARCHAR(20),       -- Carácter de la entidad (Pública/Privada/Mixta) - redundante con entidad, pero se conserva informativamente\n",
        "    otras_entidades     VARCHAR(255),      -- Otras entidades participantes (si las hay, listado)\n",
        "    modalidad_contratacion VARCHAR(100),   -- Modalidad de contratación (ej. Directa, Concurso abierto, etc.)\n",
        "    valor_cotizacion    DECIMAL(15,2),     -- Valor de la cotización/propuesta (estimación inicial)\n",
        "    valor_contrato_marco DECIMAL(15,2),    -- Valor del Contrato Marco propuesto (inicial)\n",
        "    valor_contrato_otra_fac DECIMAL(15,2), -- Valor del contrato aportado por otra facultad (si aplica)\n",
        "    valor_proyecto_fce  DECIMAL(15,2),     -- Valor del proyecto para FCE (estimado inicial)\n",
        "    tiempo_ejecucion_estimado VARCHAR(50), -- Tiempo de ejecución estimado (ej. \"3 meses\", \"1 año\")\n",
        "    fecha_recepcion     DATE,              -- Fecha de recepción de la invitación/solicitud\n",
        "    fecha_entrega       DATE,              -- Fecha de entrega de la propuesta\n",
        "    -- Estado de la propuesta se lleva en Base Maestra (estado_propuesta).\n",
        "    observaciones       TEXT,              -- Comentarios/observaciones de la etapa de propuesta\n",
        "    contacto_entidad    VARCHAR(255),      -- Datos de contacto en la entidad (persona, teléfono/email)\n",
        "    id_autorizacion_dneipi VARCHAR(50),    -- ID de autorización DNEIPI (si aplica)\n",
        "    fecha_presentacion_cf_prop DATE,       -- Fecha presentación Consejo de Facultad (propuestas/cotización)\n",
        "    acta_presentacion_cf_prop VARCHAR(50), -- Acta presentación Consejo de Facultad (propuestas/cotización)\n",
        "    -- (Campos de acuerdo de voluntades se registran en Base Maestra una vez aprobado)\n",
        "    -- Clave foránea a Base Maestra:\n",
        "    FOREIGN KEY (id_cid) REFERENCES base_maestra(id_cid)\n",
        "        ON UPDATE CASCADE ON DELETE CASCADE\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla de Ejecucion (etapa de ejecución del proyecto).\n",
        "-- Incluye campos específicos de ejecución (seguimiento contractual y financiero).\n",
        "CREATE TABLE ejecucion (\n",
        "    id_cid             INT PRIMARY KEY,    -- Misma PK que Base Maestra (1 a 1 con proyecto)\n",
        "    tipo_proyecto      VARCHAR(50),        -- Tipo de proyecto (ej. Extensión, Investigación, etc.)\n",
        "    vigencia_proyecto  VARCHAR(10),        -- Vigencia (año) del proyecto\n",
        "    contrato           VARCHAR(100),       -- Número/identificación del contrato suscrito\n",
        "    -- (Entidad, Director se obtienen de Base Maestra)\n",
        "    valor_adicion      DECIMAL(15,2),      -- Valor de adición al proyecto (montos adicionales aprobados)\n",
        "    num_vinculacion    VARCHAR(50),        -- Nº de vinculación del director (contrato del director, si aplica)\n",
        "    -- (Valor dirección está en Base Maestra)\n",
        "    -- (Acuerdo de voluntades: fecha e ID se registraron en Base Maestra)\n",
        "    fecha_inicio_ejecucion DATE,           -- Fecha de inicio de ejecución (planificada/real inicial)\n",
        "    fecha_fin_ejecucion    DATE,           -- Fecha de finalización (planificada originalmente, sin prórrogas)\n",
        "    -- (Fecha final con prórrogas está en Base Maestra)\n",
        "    -- (Modificaciones están en Base Maestra como totales)\n",
        "    fecha_fin_dir       DATE,              -- FECHA FINALIZACIÓN ORDEN DEL DIRECTOR (si aplica, p.ej. finalización según dirección)\n",
        "    -- Seguimiento de pólizas: podrían ser una tabla aparte; aquí podemos guardar indicadores si se requiere\n",
        "    poliza6            VARCHAR(50),        -- (Poliza tipo 6 - detalle o estado, en caso de manejar individualmente)\n",
        "    poliza7            VARCHAR(50),        -- (Poliza tipo 7)\n",
        "    poliza8            VARCHAR(50),        -- (Poliza tipo 8)\n",
        "    poliza9            VARCHAR(50),        -- (Poliza tipo 9)\n",
        "    gestor             VARCHAR(100),       -- Gestor del proyecto (persona encargada en ejecución)\n",
        "    responsable_ejecucion VARCHAR(100),    -- Responsable en ejecución (ej. coordinador AGEP)\n",
        "    obs_ejecucion      TEXT,               -- Observaciones de la ejecución\n",
        "    -- Seguimiento de facturación y pagos (resumen actual):\n",
        "    pago_num           INT,                -- Número de pago (secuencia del último pago realizado, si se lleva control)\n",
        "    factura_no         VARCHAR(50),        -- Factura electrónica No. (última factura emitida)\n",
        "    fecha_factura      DATE,               -- Fecha de emisión de la factura\n",
        "    fecha_vencimiento  DATE,               -- Fecha de vencimiento de la factura\n",
        "    dias_para_vencer   INT,                -- Días faltantes para vencer (si la factura está pendiente)\n",
        "    alerta_vencimiento VARCHAR(20),        -- Alerta de vencimiento (ej. 'Por vencer', 'Vencida')\n",
        "    valor_factura      DECIMAL(15,2),      -- Valor de la factura emitida\n",
        "    condiciones_pago   VARCHAR(100),       -- Condiciones y % de pago (descripción de condiciones de pago)\n",
        "    estado_factura     VARCHAR(50),        -- Estado de la factura (ej. 'Pagada', 'Pendiente')\n",
        "    comprobante_ingreso VARCHAR(50),       -- Nº Comprobante de ingreso (cuando se recibe el pago)\n",
        "    estado_pago_proy   VARCHAR(50),        -- Estado de pago en el proyecto (ej. 'Al día', 'Mora')\n",
        "    total_contratos    INT,                -- Número de contratos (subcontratos) en el proyecto, si aplica\n",
        "    contratos_pend_pago INT,               -- Nº de contratos pendientes de pago\n",
        "    valor_comprometido DECIMAL(15,2),      -- Valor comprometido (debería coincidir con presupuesto_comprometido en Base Maestra)\n",
        "    valor_pagado       DECIMAL(15,2),      -- Valor pagado hasta la fecha\n",
        "    saldo_por_ejecutar DECIMAL(15,2),      -- Saldo por ejecutar (fondos pendientes por ejecutar)\n",
        "    -- (Total facturado, %facturación, total pagado, %ingresos se reflejan en Base Maestra)\n",
        "    FOREIGN KEY (id_cid) REFERENCES base_maestra(id_cid)\n",
        "        ON UPDATE CASCADE ON DELETE CASCADE\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla de Liquidacion (etapa de liquidación del proyecto).\n",
        "-- Incluye campos específicos del cierre y liquidación contractual.\n",
        "CREATE TABLE liquidacion (\n",
        "    id_cid            INT PRIMARY KEY,    -- Misma PK de proyecto (1 a 1 con Base Maestra)\n",
        "    tipo_proyecto     VARCHAR(50),        -- Tipo de proyecto (redundante a ejecucion, incluido para referencia rápida)\n",
        "    vigencia_proyecto VARCHAR(10),        -- Vigencia del proyecto (año)\n",
        "    contrato          VARCHAR(100),       -- Nº de contrato (reiterado para referencia)\n",
        "    fecha_firma_contrato DATE,            -- Fecha de firma del contrato (si no se obtuvo antes)\n",
        "    -- (Entidad, Director obtenibles desde Base Maestra)\n",
        "    valor_contrato_total DECIMAL(15,2),   -- Valor total del contrato (incluyendo todas las partes)\n",
        "    valor_ejecucion_fce  DECIMAL(15,2),   -- Valor de ejecución FCE (lo efectivamente ejecutado por FCE)\n",
        "    fecha_inicio       DATE,              -- Fecha de inicio del contrato (ya en Base Maestra, pero se incluye si necesario)\n",
        "    fecha_fin_ejecucion DATE,             -- Fecha de fin de ejecución (sin prórrogas)\n",
        "    -- (Fecha fin con prórrogas en Base Maestra)\n",
        "    meses_ejecucion_pror INT,            -- Meses de ejecución con prórrogas\n",
        "    -- (Transferencias estimadas se registraron en Base Maestra; las reales se desglosan abajo en detalle)\n",
        "    supervisor_email   VARCHAR(100),      -- Correo electrónico del supervisor por parte de la entidad\n",
        "    estado_en_hermes   VARCHAR(50),       -- Estado del proyecto en HERMES (ej. 'Liquidado', 'Activo')\n",
        "    -- Gastos por categoría: se normalizarán en tabla aparte (liquidacion_gasto)\n",
        "    -- A continuación, campos de cierre y estados finales:\n",
        "    estado_liquidacion VARCHAR(50),       -- Estado de la liquidación (ej. 'Liquidado', 'En liquidación')\n",
        "    res_liquidacion_no VARCHAR(50),       -- Resolución de Liquidación No.\n",
        "    pdf_res_liquidacion VARCHAR(255),     -- Ruta o referencia al PDF de la Resolución de Liquidación\n",
        "    fecha_pago_transferencias DATE,       -- Fecha de pago de transferencias (a nivel central/FCE)\n",
        "    fecha_liquidacion_def DATE,           -- Fecha de Liquidación definitiva (cierre final)\n",
        "    obs_transferencias TEXT,              -- Observaciones sobre transferencias (comentarios finales)\n",
        "    fecha_envio       DATE,               -- Fecha de envío de documentación de liquidación\n",
        "    estado_liquidado_quipu  VARCHAR(50),  -- Estado liquidado en QUIPU (ej. 'Liquidado', 'Pendiente')\n",
        "    estado_liquidado_hermes VARCHAR(50),  -- Estado liquidado en HERMES\n",
        "    estado_contrato   VARCHAR(50),        -- Estado general del contrato (ej. 'Finalizado', 'Liquidado')\n",
        "    estado_rup        VARCHAR(50),        -- Estado RUP (Registro Único de Proveedores/contratos, si aplica)\n",
        "    gestion_documental VARCHAR(50),       -- Estado de gestión documental (ej. 'Completa', 'Pendiente')\n",
        "    FOREIGN KEY (id_cid) REFERENCES base_maestra(id_cid)\n",
        "        ON UPDATE CASCADE ON DELETE CASCADE\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla de Categorías de gasto en liquidación (normaliza las múltiples columnas de rubros de Liquidación).\n",
        "CREATE TABLE expense_category (\n",
        "    id_categoria   INT PRIMARY KEY AUTO_INCREMENT,\n",
        "    nombre_categoria VARCHAR(255) NOT NULL\n",
        "    -- (Ejemplos de categorías: 'Productos metálicos elaborados...', 'Impuestos', 'Servicios financieros', etc.)\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n",
        "\n",
        "-- Tabla de detalle de gastos por proyecto en cada categoría (Liquidación detallada).\n",
        "-- Cada registro representa el monto ejecutado en una categoría de gasto para el proyecto.\n",
        "CREATE TABLE liquidacion_gasto (\n",
        "    id_cid       INT NOT NULL,\n",
        "    id_categoria INT NOT NULL,\n",
        "    monto        DECIMAL(15,2) NOT NULL,\n",
        "    PRIMARY KEY (id_cid, id_categoria),\n",
        "    FOREIGN KEY (id_cid) REFERENCES base_maestra(id_cid)\n",
        "        ON DELETE CASCADE ON UPDATE CASCADE,\n",
        "    FOREIGN KEY (id_categoria) REFERENCES expense_category(id_categoria)\n",
        "        ON DELETE RESTRICT ON UPDATE CASCADE,\n",
        "    INDEX idx_gasto_categoria (id_categoria)\n",
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\n"
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "Ahora procedemos a la observación de vistas\n"
      ],
      "metadata": {
        "id": "CpTW55QpAG0w"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "-- Vista de proyectos en etapa de Propuestas: combina datos base + propuesta\n",
        "CREATE VIEW vw_propuestas AS\n",
        "SELECT\n",
        "    B.id_cid,\n",
        "    B.id_quipu,\n",
        "    B.id_hermes,\n",
        "    E.nombre_entidad AS entidad,\n",
        "    E.caracter_entidad AS caracter_entidad,\n",
        "    B.facultad_lider,\n",
        "    B.objeto,\n",
        "    B.saber_cid,\n",
        "    B.modalidad_extension,\n",
        "    P.tipologia AS tipologia_propuesta,\n",
        "    P.origen_proceso,\n",
        "    P.num_proceso,\n",
        "    P.modalidad_contratacion,\n",
        "    P.valor_cotizacion,\n",
        "    P.valor_contrato_marco AS valor_contrato_marco_estimado,\n",
        "    P.valor_contrato_otra_fac AS valor_contrato_otras_facultades,\n",
        "    P.valor_proyecto_fce AS valor_proyecto_estimado_FCE,\n",
        "    P.tiempo_ejecucion_estimado,\n",
        "    P.fecha_recepcion,\n",
        "    P.fecha_entrega,\n",
        "    B.estado_propuesta,\n",
        "    B.estado_firma,\n",
        "    P.id_autorizacion_dneipi,\n",
        "    P.fecha_presentacion_cf_prop,\n",
        "    P.acta_presentacion_cf_prop,\n",
        "    B.fecha_presentacion_cf_av,\n",
        "    B.acta_presentacion_cf_av,\n",
        "    B.id_acuerdo_voluntades,\n",
        "    B.fecha_firma_acuerdo_vol,\n",
        "    B.fecha_firma_contrato,\n",
        "    P.observaciones AS observaciones_propuesta\n",
        "FROM base_maestra B\n",
        "JOIN propuestas P ON B.id_cid = P.id_cid\n",
        "JOIN entidad E ON B.id_entidad = E.id_entidad;\n",
        "\n",
        "-- Vista de proyectos en etapa de Ejecución: combina datos base + ejecución\n",
        "CREATE VIEW vw_ejecucion AS\n",
        "SELECT\n",
        "    B.id_cid,\n",
        "    B.id_quipu,\n",
        "    B.id_hermes,\n",
        "    E.nombre_entidad AS entidad,\n",
        "    B.facultad_lider,\n",
        "    B.objeto,\n",
        "    B.modalidad_extension,\n",
        "    B.director,\n",
        "    B.tipo_vinculacion_director,\n",
        "    B.valor_contrato_fce,\n",
        "    B.presupuesto_comprometido,\n",
        "    B.porc_presupuesto_comprometido,\n",
        "    B.estado_ejecucion,\n",
        "    P.tipologia AS tipologia_propuesta,\n",
        "    X.tipo_proyecto,\n",
        "    X.vigencia_proyecto,\n",
        "    X.contrato,\n",
        "    X.valor_adicion,\n",
        "    B.valor_contrato_fce + IFNULL(X.valor_adicion,0) AS valor_proyecto_fce_total,  -- cálculo del valor final FCE (valor inicial + adición)\n",
        "    X.num_vinculacion,\n",
        "    B.fecha_inicio AS fecha_inicio_real,\n",
        "    X.fecha_inicio_ejecucion AS fecha_inicio_plan,\n",
        "    X.fecha_fin_ejecucion AS fecha_fin_plan,\n",
        "    B.fecha_finalizacion_pror AS fecha_fin_con_prorrogas,\n",
        "    X.fecha_fin_dir,\n",
        "    X.gestor,\n",
        "    X.responsable_ejecucion,\n",
        "    X.estado_pago_proy AS estado_pago_proyecto,\n",
        "    X.total_contratos,\n",
        "    X.contratos_pend_pago AS contratos_pendientes_pago,\n",
        "    X.valor_comprometido,\n",
        "    X.valor_pagado,\n",
        "    X.saldo_por_ejecutar,\n",
        "    X.obs_ejecucion AS observaciones_ejecucion\n",
        "FROM base_maestra B\n",
        "JOIN propuestas P ON B.id_cid = P.id_cid\n",
        "JOIN ejecucion X ON B.id_cid = X.id_cid\n",
        "JOIN entidad E ON B.id_entidad = E.id_entidad;\n",
        "\n",
        "-- Vista de proyectos en etapa de Liquidación: combina datos base + liquidación.\n",
        "CREATE VIEW vw_liquidacion AS\n",
        "SELECT\n",
        "    B.id_cid,\n",
        "    B.id_quipu,\n",
        "    B.id_hermes,\n",
        "    E.nombre_entidad AS entidad,\n",
        "    B.facultad_lider,\n",
        "    B.objeto,\n",
        "    B.modalidad_extension,\n",
        "    B.director,\n",
        "    L.contrato,\n",
        "    L.fecha_firma_contrato,\n",
        "    L.valor_contrato_total,\n",
        "    L.valor_ejecucion_fce,\n",
        "    B.valor_contrato_fce AS valor_contrato_fce_final,\n",
        "    B.valor_ejecutado,\n",
        "    B.excedentes,\n",
        "    L.fecha_inicio,\n",
        "    L.fecha_fin_ejecucion,\n",
        "    B.fecha_finalizacion_pror,\n",
        "    L.meses_ejecucion_pror,\n",
        "    B.fecha_liquidacion,\n",
        "    L.estado_liquidacion,\n",
        "    L.res_liquidacion_no,\n",
        "    L.fecha_liquidacion_def,\n",
        "    L.estado_liquidado_quipu,\n",
        "    L.estado_liquidado_hermes,\n",
        "    L.estado_contrato,\n",
        "    L.estado_rup,\n",
        "    L.gestion_documental,\n",
        "    L.obs_transferencias AS observaciones_liquidacion\n",
        "FROM base_maestra B\n",
        "JOIN liquidacion L ON B.id_cid = L.id_cid\n",
        "JOIN entidad E ON B.id_entidad = E.id_entidad;\n"
      ],
      "metadata": {
        "id": "Mm1aKjSIAN1D"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "DELIMITER $$\n",
        "\n",
        "-- Trigger: Antes de UPDATE en base_maestra – genera códigos cuando estado_firma cambia a 'Firmado'\n",
        "CREATE TRIGGER trg_base_before_update\n",
        "BEFORE UPDATE ON base_maestra\n",
        "FOR EACH ROW\n",
        "BEGIN\n",
        "    IF NEW.estado_firma = 'Firmado' AND (OLD.estado_firma <> 'Firmado' OR OLD.estado_firma IS NULL) THEN\n",
        "        -- Generar código QUIPU si no está asignado\n",
        "        IF NEW.id_quipu IS NULL OR NEW.id_quipu = '' THEN\n",
        "            SET NEW.id_quipu = CONCAT('QUIPU-', NEW.id_cid);\n",
        "        END IF;\n",
        "        -- Generar código HERMES si no está asignado\n",
        "        IF NEW.id_hermes IS NULL OR NEW.id_hermes = '' THEN\n",
        "            SET NEW.id_hermes = CONCAT('HERMES-', NEW.id_cid);\n",
        "        END IF;\n",
        "    END IF;\n",
        "END$$\n",
        "\n",
        "-- Trigger: Después de INSERT en base_maestra – genera códigos si un registro entra ya aprobado (Firmado)\n",
        "CREATE TRIGGER trg_base_after_insert\n",
        "AFTER INSERT ON base_maestra\n",
        "FOR EACH ROW\n",
        "BEGIN\n",
        "    IF NEW.estado_firma = 'Firmado' THEN\n",
        "        UPDATE base_maestra\n",
        "        SET id_quipu = CONCAT('QUIPU-', NEW.id_cid),\n",
        "            id_hermes = CONCAT('HERMES-', NEW.id_cid)\n",
        "        WHERE id_cid = NEW.id_cid;\n",
        "    END IF;\n",
        "END$$\n",
        "\n",
        "DELIMITER ;"
      ],
      "metadata": {
        "id": "-IwkjdCJAf1k"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Procedimientos para registrar proyectos aprobados"
      ],
      "metadata": {
        "id": "lbzhoHP47JzP"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "DELIMITER $$\n",
        "CREATE PROCEDURE crear_proyecto (\n",
        "    IN p_id_entidad INT,\n",
        "    IN p_facultad_lider VARCHAR(100),\n",
        "    IN p_objeto TEXT,\n",
        "    IN p_tipologia VARCHAR(50),\n",
        "    IN p_origen_proceso VARCHAR(100),\n",
        "    IN p_valor_cotizacion DECIMAL(15,2),\n",
        "    IN p_valor_proyecto_fce DECIMAL(15,2),\n",
        "    IN p_fecha_recepcion DATE,\n",
        "    IN p_fecha_entrega DATE,\n",
        "    IN p_fecha_inicio_ejecucion DATE,\n",
        "    IN p_fecha_fin_ejecucion DATE,\n",
        "    IN p_valor_pagado DECIMAL(15,2),\n",
        "    IN p_condiciones_pago VARCHAR(100),\n",
        "    IN p_valor_contrato_total DECIMAL(15,2),\n",
        "    IN p_valor_ejecucion_fce DECIMAL(15,2),\n",
        "    IN p_res_liquidacion_no VARCHAR(50),\n",
        "    IN p_fecha_liquidacion_def DATE,\n",
        "    IN p_estado_liquidacion VARCHAR(50)\n",
        ")\n",
        "BEGIN\n",
        "    -- Declaración de variables locales\n",
        "    DECLARE v_lastHermes INT DEFAULT 0;\n",
        "    DECLARE v_lastQuipu INT DEFAULT 0;\n",
        "    DECLARE v_newHermesCode VARCHAR(50);\n",
        "    DECLARE v_newQuipuCode VARCHAR(50);\n",
        "    DECLARE v_newCid INT;\n",
        "\n",
        "    -- Manejador de errores: ante cualquier excepción SQL, deshacer la transacción\n",
        "    DECLARE EXIT HANDLER FOR SQLEXCEPTION\n",
        "    BEGIN\n",
        "        ROLLBACK;\n",
        "        RESIGNAL;  -- Propagar el error después de rollback\n",
        "    END;\n",
        "\n",
        "    START TRANSACTION;\n",
        "    -- 1. Validar que la entidad existe\n",
        "    IF (SELECT COUNT(*) FROM entidad WHERE id_entidad = p_id_entidad) = 0 THEN\n",
        "        SIGNAL SQLSTATE '45000'\n",
        "            SET MESSAGE_TEXT = 'Error: la entidad especificada (id_entidad) no existe.';\n",
        "    END IF;\n",
        "\n",
        "    -- 2. Generar código HERMES (HERMES-YYYY-NNN)\n",
        "    SELECT COALESCE(\n",
        "               MAX(CAST(SUBSTRING_INDEX(id_hermes, '-', -1) AS UNSIGNED)),\n",
        "               0\n",
        "           )\n",
        "    INTO v_lastHermes\n",
        "    FROM base_maestra\n",
        "    WHERE id_hermes LIKE CONCAT('HERMES-', YEAR(CURDATE()), '-%');\n",
        "    SET v_newHermesCode = CONCAT('HERMES-', YEAR(CURDATE()), '-', LPAD(v_lastHermes + 1, 3, '0'));\n",
        "\n",
        "    -- 3. Generar código QUIPU (QYYYY-NNN)\n",
        "    SELECT COALESCE(\n",
        "               MAX(CAST(SUBSTRING_INDEX(id_quipu, '-', -1) AS UNSIGNED)),\n",
        "               0\n",
        "           )\n",
        "    INTO v_lastQuipu\n",
        "    FROM base_maestra\n",
        "    WHERE id_quipu LIKE CONCAT('Q', YEAR(CURDATE()), '-%');\n",
        "    SET v_newQuipuCode = CONCAT('Q', YEAR(CURDATE()), '-', LPAD(v_lastQuipu + 1, 3, '0'));\n",
        "\n",
        "    -- 4. Insertar en base_maestra\n",
        "    INSERT INTO base_maestra (id_entidad, id_quipu, id_hermes, facultad_lider, objeto)\n",
        "    VALUES (p_id_entidad, v_newQuipuCode, v_newHermesCode, p_facultad_lider, p_objeto);\n",
        "\n",
        "    -- Obtener el id_cid generado para el nuevo proyecto\n",
        "    SET v_newCid = LAST_INSERT_ID();\n",
        "\n",
        "    -- 5. Insertar en propuestas (datos de la propuesta del proyecto)\n",
        "    INSERT INTO propuestas (id_cid, tipologia, origen_proceso, valor_cotizacion, valor_proyecto_fce,\n",
        "                             fecha_recepcion, fecha_entrega)\n",
        "    VALUES (v_newCid, p_tipologia, p_origen_proceso, p_valor_cotizacion, p_valor_proyecto_fce,\n",
        "            p_fecha_recepcion, p_fecha_entrega);\n",
        "\n",
        "    -- 6. Insertar en ejecucion (datos de la fase de ejecución)\n",
        "    INSERT INTO ejecucion (id_cid, fecha_inicio_ejecucion, fecha_fin_ejecucion, valor_pagado, condiciones_pago)\n",
        "    VALUES (v_newCid, p_fecha_inicio_ejecucion, p_fecha_fin_ejecucion, p_valor_pagado, p_condiciones_pago);\n",
        "\n",
        "    -- 7. Insertar en liquidacion (datos de la liquidación final)\n",
        "    INSERT INTO liquidacion (id_cid, valor_contrato_total, valor_ejecucion_fce, res_liquidacion_no,\n",
        "                              fecha_liquidacion_def, estado_liquidacion)\n",
        "    VALUES (v_newCid, p_valor_contrato_total, p_valor_ejecucion_fce, p_res_liquidacion_no,\n",
        "            p_fecha_liquidacion_def, p_estado_liquidacion);\n",
        "\n",
        "    -- 8. Confirmar todos los cambios\n",
        "    COMMIT;\n",
        "END$$\n",
        "DELIMITER ;\n"
      ],
      "metadata": {
        "id": "7_vgRlf-U68G"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Este procedimiento se parametrizó con la finalidad de brindar una base para un llamado más complejo, utilizando un solo procedimiento que reciba una serie de datos compleja y que llene varias casillas de las tablas simultáneamente. A continuación se observa el llamado realizado con los datos por almacenar en un solo llamado."
      ],
      "metadata": {
        "id": "H6zAQ7pXLiFW"
      }
    },
    {
      "cell_type": "markdown",
      "source": [
        "el llamado abajo es para el proyecto 1 con 18 parámetros"
      ],
      "metadata": {
        "id": "hfnobpixYDe5"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "CALL crear_proyecto(\n",
        "    1, -- p_id_entidad (verifica que exista en la tabla 'entidad')\n",
        "    'Facultad de Ingeniería Biomédica', -- p_facultad_lider\n",
        "    'Plataforma de Telemedicina Rural', -- p_objeto\n",
        "    'Convocatoria pública de I+D', -- p_tipologia\n",
        "    'Licitación pública nacional (convocatoria MinSalud 2019)', -- p_origen_proceso\n",
        "    500000000, -- p_valor_cotizacion\n",
        "    500000000, -- p_valor_proyecto_fce (valor contrato inicial)\n",
        "    '2019-12-20', -- p_fecha_recepcion propuesta\n",
        "    '2020-03-10', -- p_fecha_entrega propuesta aprobada\n",
        "    '2020-04-01', -- p_fecha_inicio_ejecucion\n",
        "    '2021-03-31', -- p_fecha_fin_ejecucion\n",
        "    480000000, -- p_valor_pagado (valor efectivamente pagado)\n",
        "    'Pago contra entrega de cada módulo funcional; 30 días plazo', -- p_condiciones_pago\n",
        "    500000000, -- p_valor_contrato_total (valor total presupuestado)\n",
        "    480000000, -- p_valor_ejecucion_fce (valor total ejecutado)\n",
        "    '210-2021', -- p_res_liquidacion_no (resolución de liquidación)\n",
        "    '2021-04-30', -- p_fecha_liquidacion_def\n",
        "    'Liquidado' -- p_estado_liquidacion\n",
        ");\n"
      ],
      "metadata": {
        "id": "oRGkQr5TXFeb"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "el llamado abajo es para agregar el proyecto 2 con los mismos 18 parámetros que acepta el procedimiento almacenado."
      ],
      "metadata": {
        "id": "FKWwdgxKYL5K"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "CALL crear_proyecto(\n",
        "    2, -- p_id_entidad (verifica que exista, ej.: id_entidad = 2)\n",
        "    'Facultad de Ingeniería Ambiental', -- p_facultad_lider\n",
        "    'Estudio de Impacto Ambiental para un tramo vial', -- p_objeto\n",
        "    'Convocatoria pública de I+D', -- p_tipologia\n",
        "    'Licitación pública nacional (convocatoria MinSalud 2019)', -- p_origen_proceso\n",
        "    180000000, -- p_valor_cotizacion\n",
        "    180000000, -- p_valor_proyecto_fce (valor contrato inicial)\n",
        "    '2019-07-10', -- p_fecha_recepcion propuesta (asumida cercana presentación: 10 días antes de adjudicación)\n",
        "    '2019-07-30', -- p_fecha_entrega propuesta aprobada (fecha adjudicación)\n",
        "    '2019-08-05', -- p_fecha_inicio_ejecucion (asumida 5 días luego de firma contrato)\n",
        "    '2020-04-30', -- p_fecha_fin_ejecucion (fecha real finalización con prórroga)\n",
        "    170000000, -- p_valor_pagado (valor efectivamente recibido antes de liquidación)\n",
        "    '50% anticipado, 50% al finalizar con plazo 30 días', -- p_condiciones_pago\n",
        "    180000000, -- p_valor_contrato_total (presupuesto total aprobado)\n",
        "    180000000, -- p_valor_ejecucion_fce (valor efectivamente ejecutado)\n",
        "    '65-2020', -- p_res_liquidacion_no (resolución de liquidación)\n",
        "    '2020-06-15', -- p_fecha_liquidacion_def\n",
        "    'Liquidado' -- p_estado_liquidacion\n",
        ");\n"
      ],
      "metadata": {
        "id": "KCB5oQBgYTlD"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "ahora para el proyecto liquidad nº 3"
      ],
      "metadata": {
        "id": "aLzRwfIock_k"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "CALL crear_proyecto(\n",
        "    3, -- p_id_entidad (verifica que exista, por ejemplo, entidad 3)\n",
        "    'Facultad de Ingeniería Eléctrica', -- p_facultad_lider\n",
        "    'Investigación en Impacto Ambiental para un tramo vial', -- p_objeto\n",
        "    'Convocatoria pública de I+D', -- p_tipologia\n",
        "    'Convocatoria pública MinCiencias 2018 (propuestas de investigación competitivas)', -- p_origen_proceso\n",
        "    300000000, -- p_valor_cotizacion\n",
        "    300000000, -- p_valor_proyecto_fce (presupuesto inicial)\n",
        "    '2018-07-10', -- p_fecha_recepcion (aproximado 20 días antes adjudicación)\n",
        "    '2018-01-30', -- p_fecha_entrega (adjudicación)\n",
        "    '2018-03-01', -- p_fecha_inicio_ejecucion\n",
        "    '2020-06-30', -- p_fecha_fin_ejecucion (fecha real, extendida)\n",
        "    300000000, -- p_valor_pagado (total recibido finalmente tras aprobaciones)\n",
        "    '40% al inicio, 40% intermedio tras informe, 20% final aprobación', -- p_condiciones_pago\n",
        "    300000000, -- p_valor_contrato_total (presupuesto original aprobado)\n",
        "    300000000, -- p_valor_ejecucion_fce (valor efectivamente ejecutado tras adición)\n",
        "    '198-2020', -- p_res_liquidacion_no (resolución liquidación)\n",
        "    '2020-08-31', -- p_fecha_liquidacion_def\n",
        "    'Liquidado' -- p_estado_liquidacion\n",
        ");\n"
      ],
      "metadata": {
        "id": "eq2SK6JPco0W"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "proyecto nº 4"
      ],
      "metadata": {
        "id": "sqP_Pis1h6EH"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "CALL crear_proyecto(\n",
        "    4, -- p_id_entidad (asegúrate que exista en tabla entidad)\n",
        "    'Facultad de Arquitectura y Urbanismo', -- p_facultad_lider\n",
        "    'Sistema GIS para Catastro Regional', -- p_objeto\n",
        "    'Proyecto de servicio (Desarrollo e implementación de sistema)', -- p_tipologia\n",
        "    'Licitación pública regional No. SPR-2020-45', -- p_origen_proceso\n",
        "    250000000, -- p_valor_cotizacion\n",
        "    250000000, -- p_valor_proyecto_fce (valor inicial contratado)\n",
        "    '2020-12-05', -- p_fecha_recepcion propuesta\n",
        "    '2021-01-05', -- p_fecha_entrega propuesta aprobada (fecha adjudicación)\n",
        "    '2021-01-20', -- p_fecha_inicio_ejecucion\n",
        "    '2021-12-31', -- p_fecha_fin_ejecucion (fecha real con retraso administrativo)\n",
        "    247500000, -- p_valor_pagado (valor final recibido tras penalidad)\n",
        "    'Pago trimestral contra entrega, plazo 45 días, último pago con penalidad 1%', -- p_condiciones_pago\n",
        "    250000000, -- p_valor_contrato_total (valor total aprobado)\n",
        "    250000000, -- p_valor_ejecucion_fce (valor ejecutado 100%)\n",
        "    '110-2022', -- p_res_liquidacion_no (resolución liquidación)\n",
        "    '2022-03-31', -- p_fecha_liquidacion_def\n",
        "    'Liquidado' -- p_estado_liquidacion\n",
        ");\n"
      ],
      "metadata": {
        "id": "YSUMQFlMiA7Z"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "finalmente el último proyecto liquidado"
      ],
      "metadata": {
        "id": "IfPL_2mMi_Qy"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "CALL crear_proyecto(\n",
        "    5, -- p_id_entidad (verifica que exista, ej.: entidad 5)\n",
        "    'Facultad de Ciencias de la Educación', -- p_facultad_lider\n",
        "    'Aplicación Educativa Multiplataforma', -- p_objeto\n",
        "    'Contrato de servicio', -- p_tipologia\n",
        "    'Invitación directa de la fundación (convocatoria cerrada a universidades)', -- p_origen_proceso\n",
        "    100000000, -- p_valor_cotizacion\n",
        "    100000000, -- p_valor_proyecto_fce (valor original del contrato)\n",
        "    '2022-03-10', -- p_fecha_recepcion propuesta\n",
        "    '2022-03-28', -- p_fecha_entrega propuesta aprobada (adjudicación)\n",
        "    '2022-04-15', -- p_fecha_inicio_ejecucion\n",
        "    '2022-12-15', -- p_fecha_fin_ejecucion (fecha de finalización real en plazo)\n",
        "    95000000, -- p_valor_pagado (valor efectivamente recibido con ahorro)\n",
        "    'Pago por hitos contra entrega, plazo 15 días', -- p_condiciones_pago\n",
        "    100000000, -- p_valor_contrato_total (presupuesto total aprobado inicialmente)\n",
        "    95000000, -- p_valor_ejecucion_fce (valor efectivamente ejecutado)\n",
        "    '05-2023', -- p_res_liquidacion_no (resolución de liquidación)\n",
        "    '2023-01-31', -- p_fecha_liquidacion_def\n",
        "    'Liquidado' -- p_estado_liquidacion\n",
        ");\n"
      ],
      "metadata": {
        "id": "y8bPSqJojCRp"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "Procedemos con una modificacion en proyectos en ejecucion realizada en multiples llamados parametrizados para ingresar 20 proyectos distintos. 5 iniciales y 15 en tandem."
      ],
      "metadata": {
        "id": "5XQI7BgCrtcg"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "-- Proyecto 1: Sistema Nacional de Información Económica\n",
        "\n",
        "CALL crear_proyecto(\n",
        "    2,\n",
        "    'Facultad de Economía',\n",
        "    'Sistema Nacional de Información Económica',\n",
        "    'Desarrollo tecnológico',\n",
        "    'Licitación pública nacional 2023-ECO-01',\n",
        "    750000000,\n",
        "    750000000,\n",
        "    '2023-12-01',\n",
        "    '2024-01-05',\n",
        "    '2024-01-15',\n",
        "    '2025-01-15',\n",
        "    450000000,\n",
        "    'Pagos trimestrales por avances aprobados',\n",
        "    750000000,\n",
        "    450000000,\n",
        "    NULL, -- resolución liquidación aún no existe\n",
        "    NULL, -- fecha liquidación aún no existe\n",
        "    'En ejecución'\n",
        ");\n",
        "\n",
        "\n",
        "-- Proyecto 2: Programa Nacional de Prevención de Fraudes\n",
        "\n",
        "CALL crear_proyecto(\n",
        "    5, -- Superintendencia de Industria y Comercio (verifica id real)\n",
        "    'Facultad de Administración y Finanzas',\n",
        "    'Programa Nacional de Prevención de Fraudes',\n",
        "    'Consultoría',\n",
        "    'Contratación directa - invitación cerrada SIC-2023-05',\n",
        "    200000000,\n",
        "    200000000,\n",
        "    '2023-05-10',\n",
        "    '2023-05-25',\n",
        "    '2023-06-01',\n",
        "    '2024-05-31',\n",
        "    170000000, -- 85% ejecutado hasta ahora\n",
        "    '50% inicial, 50% restante contra informes parciales aprobados',\n",
        "    200000000,\n",
        "    170000000,\n",
        "\tNULL, -- resolución liquidación aún no existe\n",
        "    NULL, -- fecha liquidación aún no existe\n",
        "    'En ejecución'\n",
        ");\n",
        "\n",
        "--  Proyecto 3: Plataforma Digital de Gestión Infantil\n",
        "CALL crear_proyecto(\n",
        "    6, -- Instituto Colombiano de Bienestar Familiar (ICBF)\n",
        "    'Facultad de Ciencias Sociales',\n",
        "    'Plataforma Digital de Gestión Infantil',\n",
        "    'Software educativo',\n",
        "    'Convocatoria pública ICBF-2024-07',\n",
        "    350000000,\n",
        "    350000000,\n",
        "    '2024-01-20',\n",
        "    '2024-02-05',\n",
        "    '2024-02-10',\n",
        "    '2024-12-10',\n",
        "    140000000, -- 40% ejecutado\n",
        "    'Pagos por entregas parciales aprobadas, plazo 30 días',\n",
        "    350000000,\n",
        "    140000000,\n",
        "    NULL, -- resolución liquidación aún no existe\n",
        "    NULL, -- fecha liquidación aún no existe\n",
        "    'En ejecución'\n",
        ");\n",
        "-- Proyecto 4: Sistema Integrado de Control Fiscal\n",
        "\n",
        "CALL crear_proyecto(\n",
        "    4, -- Contraloría General de la República\n",
        "    'Facultad de Ingeniería Industrial',\n",
        "    'Sistema Integrado de Control Fiscal',\n",
        "    'Implementación ERP',\n",
        "    'Licitación pública nacional CGR-2023-10',\n",
        "    600000000,\n",
        "    600000000,\n",
        "    '2023-09-01',\n",
        "    '2023-09-25',\n",
        "    '2023-10-01',\n",
        "    '2024-09-30',\n",
        "    300000000, -- 50% ejecutado\n",
        "    'Pagos bimestrales contra entregables, 45 días plazo',\n",
        "    600000000,\n",
        "    300000000,\n",
        "\tNULL, -- resolución liquidación aún no existe\n",
        "    NULL, -- fecha liquidación aún no existe\n",
        "    'En ejecución'\n",
        ");\n",
        "-- Proyecto 5: Portal Único de Trámites Estatales\n",
        "\n",
        "CALL crear_proyecto(\n",
        "    1, -- Presidencia de la República de Colombia\n",
        "    'Facultad de Ingeniería de Sistemas',\n",
        "    'Portal Único de Trámites Estatales',\n",
        "    'Servicio tecnológico',\n",
        "    'Convocatoria pública presidencial - CPU-2024-01',\n",
        "    1000000000,\n",
        "    1000000000,\n",
        "    '2024-01-15',\n",
        "    '2024-02-15',\n",
        "    '2024-03-01',\n",
        "    '2025-02-28',\n",
        "    250000000, -- 25% ejecutado\n",
        "    'Pagos trimestrales por avance, plazo 30 días',\n",
        "    1000000000,\n",
        "    250000000,\n",
        "\tNULL, -- resolución liquidación aún no existe\n",
        "    NULL, -- fecha liquidación aún no existe\n",
        "    'En ejecución'\n",
        ");\n"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 106
        },
        "id": "bpw8jq1zr0Wj",
        "outputId": "44859e94-6d8c-4709-da70-6821e91dd6cb"
      },
      "execution_count": 10,
      "outputs": [
        {
          "output_type": "error",
          "ename": "SyntaxError",
          "evalue": "invalid syntax (<ipython-input-10-486b2f6bc0b3>, line 1)",
          "traceback": [
            "\u001b[0;36m  File \u001b[0;32m\"<ipython-input-10-486b2f6bc0b3>\"\u001b[0;36m, line \u001b[0;32m1\u001b[0m\n\u001b[0;31m    -- Proyecto 1: Sistema Nacional de Información Económica\u001b[0m\n\u001b[0m                ^\u001b[0m\n\u001b[0;31mSyntaxError\u001b[0m\u001b[0;31m:\u001b[0m invalid syntax\n"
          ]
        }
      ]
    },
    {
      "cell_type": "markdown",
      "source": [
        "siguiendo la lógica anterior se creó la siguiente tabla para el llenado de los datos que almacena los registros de otros 16 proyectos que están en etapa de ejecución y porcentajes de avance en las obras"
      ],
      "metadata": {
        "id": "IaXvFfoR1sWD"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "-- Proyecto 6: Sistema Nacional de Seguridad Vial\n",
        "CALL crear_proyecto(3,'Facultad de Ingeniería Civil','Sistema Nacional de Seguridad Vial','Consultoría técnica','Licitación pública nacional DNP-2024-09',450000000,450000000,'2024-01-15','2024-01-30','2024-01-15','2025-01-15',270000000,'Pagos trimestrales por avances aprobados',450000000,270000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 7: Auditoría de Procesos Públicos\n",
        "CALL crear_proyecto(4,'Facultad de Contaduría Pública','Auditoría de Procesos Públicos','Auditoría especializada','Contratación directa CGR-2023-08',150000000,150000000,'2023-05-01','2023-05-20','2023-06-01','2024-06-01',75000000,'50% inicial, 50% restante contra informes parciales aprobados',150000000,75000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 8: Educación Financiera Digital\n",
        "CALL crear_proyecto(2,'Facultad de Economía','Educación Financiera Digital','Desarrollo software','Convocatoria abierta MHCP-2024-01',220000000,220000000,'2024-02-15','2024-03-05','2024-03-01','2024-11-30',66000000,'Pagos trimestrales por avances aprobados',220000000,88000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 9: Sistema Integrado de Salud Pública\n",
        "CALL crear_proyecto(6,'Facultad de Salud Pública','Sistema Integrado de Salud Pública','Implementación tecnológica','Licitación nacional ICBF-2024-02',550000000,550000000,'2024-01-01','2024-01-20','2024-02-01','2025-01-31',220000000,'Pagos semestrales contra entregables aprobados',550000000,220000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 10: Plataforma Nacional de Innovación Digital\n",
        "CALL crear_proyecto(1,'Facultad de Ingeniería de Sistemas','Plataforma Nacional de Innovación Digital','Implementación tecnológica','Convocatoria presidencial CPU-2024-02',800000000,800000000,'2024-02-01','2024-02-28','2024-03-10','2025-03-09',200000000,'Pagos por entregables aprobados, plazo 30 días',800000000,200000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 11: Sistema de Transparencia Pública\n",
        "CALL crear_proyecto(4,'Facultad de Derecho','Sistema de Transparencia Pública','Consultoría','Licitación pública nacional CGR-2024-11',400000000,400000000,'2024-03-15','2024-04-01','2024-04-15','2025-04-14',160000000,'Pagos trimestrales contra entregas parciales aprobadas',400000000,160000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 12: Programa Nacional de Innovación Empresarial\n",
        "CALL crear_proyecto(2,'Facultad de Administración','Programa Nacional de Innovación Empresarial','Investigación aplicada','Convocatoria MHCP-2024-06',600000000,600000000,'2024-05-01','2024-05-20','2024-06-01','2025-05-31',90000000,'Pagos trimestrales por avances',600000000,90000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 13: Plataforma de Monitoreo Económico\n",
        "CALL crear_proyecto(2,'Facultad de Economía','Plataforma de Monitoreo Económico','Desarrollo software','Licitación pública nacional MHCP-2024-04',350000000,350000000,'2024-03-01','2024-03-20','2024-04-01','2025-03-31',105000000,'Pagos trimestrales por avance',350000000,105000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 14: Campaña Nacional de Prevención de Corrupción\n",
        "CALL crear_proyecto(4,'Facultad de Ciencias Sociales','Campaña Nacional de Prevención de Corrupción','Campaña de sensibilización','Contratación directa CGR-2024-01',250000000,250000000,'2024-01-05','2024-01-20','2024-02-01','2024-12-31',125000000,'Pagos bimestrales por avance aprobado',250000000,125000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 15: Sistema Inteligente de Auditoría\n",
        "CALL crear_proyecto(4,'Facultad de Ingeniería de Sistemas','Sistema Inteligencia Artificial Auditoría Fiscal','Implementación tecnológica','Licitación CGR-2024-05',850000000,850000000,'2024-04-10','2024-04-30','2024-05-15','2025-05-14',212500000,'Pagos trimestrales',850000000,212500000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 16: Plataforma Digital Educativa Juvenil\n",
        "CALL crear_proyecto(6,'Facultad de Educación','Plataforma de Educación Financiera Juvenil','Software educativo móvil','Convocatoria pública ICBF-2024-04',280000000,280000000,'2024-03-15','2024-03-30','2024-04-01','2024-12-31',98000000,'Pagos trimestrales',280000000,98000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 16: Implementación Blockchain para Contratos Públicos\n",
        "CALL crear_proyecto(5,'Facultad de Ingeniería de Sistemas','Implementación Blockchain para Contratos Públicos','Tecnología Blockchain','Convocatoria abierta SIC-2024-15',700000000,700000000,'2024-03-01','2024-03-25','2024-04-01','2025-04-01',210000000,'Pagos trimestrales contra entregables aprobados',700000000,210000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 17: Sistema de Gestión Territorial\n",
        "CALL crear_proyecto(3,'Facultad de Geografía','Sistema de Gestión Territorial','Desarrollo GIS','Licitación regional DNP-2024-11',400000000,400000000,'2024-02-20','2024-03-15','2024-04-01','2025-03-31',80000000,'Pagos trimestrales por avances aprobados',400000000,80000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 18: Sistema Nacional de Control de Medicamentos\n",
        "CALL crear_proyecto(6,'Facultad de Salud Pública','Sistema Nacional de Monitoreo Farmacéutico','Implementación tecnológica','Convocatoria pública nacional ICBF-2024-06',550000000,550000000,'2024-02-01','2024-02-20','2024-03-05','2025-03-04',110000000,'Pagos trimestrales contra entregas parciales aprobadas',550000000,110000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 19: Observatorio Nacional de Planeación Urbana\n",
        "CALL crear_proyecto(3,'Facultad de Arquitectura y Urbanismo','Sistema de Información Territorial','Software de planificación urbana','Licitación pública nacional DNP-2024-12',450000000,450000000,'2024-03-01','2024-03-25','2024-04-10','2025-04-09',90000000,'Pagos trimestrales, plazo 30 días contra entregables',450000000,90000000,NULL,NULL,'En ejecución');\n",
        "\n",
        "-- Proyecto 20: Programa Nacional de Emprendimiento Juvenil\n",
        "CALL crear_proyecto(3,'Facultad de Ciencias Económicas','Programa Nacional de Emprendimiento Juvenil','Programa de formación','Convocatoria pública DNP-2024-03',300000000,300000000,'2024-02-20','2024-03-05','2024-03-20','2025-03-19',60000000,'Pagos por etapas de formación concluidas, plazo 30 días',300000000,60000000,NULL,NULL,'En ejecución');\n"
      ],
      "metadata": {
        "id": "c0G_B5Ry1vtJ"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "el código incluido debajo no está testeado, presenta errores o no tiene estructura suficiente para ser util en combinación con las tablas establecidas. se utiliza solo como referencia."
      ],
      "metadata": {
        "id": "90MHAEG9MZ4f"
      }
    },
    {
      "cell_type": "code",
      "source": [],
      "metadata": {
        "id": "vHVrvEP4Qm65"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "DELIMITER $$\n",
        "\n",
        "-- Procedimiento 3: Insertar Proyecto 3\n",
        "CREATE PROCEDURE InsertarProyecto3()\n",
        "BEGIN\n",
        "    -- Declaración de variables locales\n",
        "    DECLARE newProjectID INT;\n",
        "    DECLARE nuevoCodigoHermes VARCHAR(15);\n",
        "    DECLARE nuevoCodigoQuipu VARCHAR(15);\n",
        "\n",
        "    -- 1. Insertar datos generales del proyecto en Base Maestra\n",
        "    INSERT INTO base_maestra (nombre_proyecto, director, codigo_hermes, codigo_quipu)\n",
        "    VALUES ('Desarrollo de Aplicación Móvil', 'Carlos Rodríguez', NULL, NULL);\n",
        "    SET newProjectID = LAST_INSERT_ID();\n",
        "\n",
        "    -- 2. Generar códigos HERMES y QUIPU\n",
        "    SET nuevoCodigoHermes = CONCAT('HERMES', LPAD(newProjectID, 3, '0'));\n",
        "    SET nuevoCodigoQuipu  = CONCAT('QUIPU',  LPAD(newProjectID, 3, '0'));\n",
        "    UPDATE base_maestra\n",
        "    SET codigo_hermes = nuevoCodigoHermes,\n",
        "        codigo_quipu  = nuevoCodigoQuipu\n",
        "    WHERE id = newProjectID;\n",
        "\n",
        "    -- 3. Insertar datos de la propuesta (cotización y fechas)\n",
        "    INSERT INTO propuestas (proyecto_id, valor_cotizacion, fecha_propuesta, fecha_aprobacion)\n",
        "    VALUES (newProjectID, 120000, '2020-03-10', '2020-06-30');\n",
        "\n",
        "    -- 4. Insertar información de la ejecución (vigencia, pagos, fechas)\n",
        "    INSERT INTO ejecucion (proyecto_id, vigencia, pagos, fecha_inicio, fecha_fin)\n",
        "    VALUES (newProjectID, 2021, 4, '2021-01-05', '2021-12-31');\n",
        "\n",
        "    -- 5. Insertar datos de liquidación (fecha y observaciones)\n",
        "    INSERT INTO liquidacion (proyecto_id, fecha_liquidacion, observaciones)\n",
        "    VALUES (newProjectID, '2022-02-10', 'Proyecto liquidado sin inconvenientes.');\n",
        "\n",
        "    -- Mensaje de confirmación\n",
        "    SELECT 'Proyecto \\\"Desarrollo de Aplicación Móvil\\\" insertado correctamente.' AS resultado;\n",
        "END $$\n",
        "\n",
        "DELIMITER ;"
      ],
      "metadata": {
        "id": "ATn92JeI7Vmw"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "DELIMITER $$\n",
        "\n",
        "-- Procedimiento 4: Insertar Proyecto 4\n",
        "CREATE PROCEDURE InsertarProyecto4()\n",
        "BEGIN\n",
        "    -- Declaración de variables locales\n",
        "    DECLARE newProjectID INT;\n",
        "    DECLARE nuevoCodigoHermes VARCHAR(15);\n",
        "    DECLARE nuevoCodigoQuipu VARCHAR(15);\n",
        "\n",
        "    -- 1. Insertar datos generales del proyecto en Base Maestra\n",
        "    INSERT INTO base_maestra (nombre_proyecto, director, codigo_hermes, codigo_quipu)\n",
        "    VALUES ('Investigación en Energías Renovables', 'Luisa Fernández', NULL, NULL);\n",
        "    SET newProjectID = LAST_INSERT_ID();\n",
        "\n",
        "    -- 2. Generar códigos HERMES y QUIPU\n",
        "    SET nuevoCodigoHermes = CONCAT('HERMES', LPAD(newProjectID, 3, '0'));\n",
        "    SET nuevoCodigoQuipu  = CONCAT('QUIPU',  LPAD(newProjectID, 3, '0'));\n",
        "    UPDATE base_maestra\n",
        "    SET codigo_hermes = nuevoCodigoHermes,\n",
        "        codigo_quipu  = nuevoCodigoQuipu\n",
        "    WHERE id = newProjectID;\n",
        "\n",
        "    -- 3. Insertar datos de la propuesta (cotización y fechas)\n",
        "    INSERT INTO propuestas (proyecto_id, valor_cotizacion, fecha_propuesta, fecha_aprobacion)\n",
        "    VALUES (newProjectID, 30000, '2017-08-01', '2017-10-15');\n",
        "\n",
        "    -- 4. Insertar información de la ejecución (vigencia, pagos, fechas)\n",
        "    INSERT INTO ejecucion (proyecto_id, vigencia, pagos, fecha_inicio, fecha_fin)\n",
        "    VALUES (newProjectID, 2018, 2, '2018-01-10', '2018-12-10');\n",
        "\n",
        "    -- 5. Insertar datos de liquidación (fecha y observaciones)\n",
        "    INSERT INTO liquidacion (proyecto_id, fecha_liquidacion, observaciones)\n",
        "    VALUES (newProjectID, '2019-01-20', 'Cierre financiero sin pendientes.');\n",
        "\n",
        "    -- Mensaje de confirmación\n",
        "    SELECT 'Proyecto \\\"Investigación en Energías Renovables\\\" insertado correctamente.' AS resultado;\n",
        "END $$\n",
        "\n",
        "DELIMITER ;\n"
      ],
      "metadata": {
        "id": "t2vmXLDS7VXd"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "DELIMITER $$\n",
        "\n",
        "-- Procedimiento 5: Insertar Proyecto 5\n",
        "CREATE PROCEDURE InsertarProyecto5()\n",
        "BEGIN\n",
        "    -- Declaración de variables locales\n",
        "    DECLARE newProjectID INT;\n",
        "    DECLARE nuevoCodigoHermes VARCHAR(15);\n",
        "    DECLARE nuevoCodigoQuipu VARCHAR(15);\n",
        "\n",
        "    -- 1. Insertar datos generales del proyecto en Base Maestra\n",
        "    INSERT INTO base_maestra (nombre_proyecto, director, codigo_hermes, codigo_quipu)\n",
        "    VALUES ('Proyecto de Mejora Educativa', 'Ana Martínez', NULL, NULL);\n",
        "    SET newProjectID = LAST_INSERT_ID();\n",
        "\n",
        "    -- 2. Generar códigos HERMES y QUIPU\n",
        "    SET nuevoCodigoHermes = CONCAT('HERMES', LPAD(newProjectID, 3, '0'));\n",
        "    SET nuevoCodigoQuipu  = CONCAT('QUIPU',  LPAD(newProjectID, 3, '0'));\n",
        "    UPDATE base_maestra\n",
        "    SET codigo_hermes = nuevoCodigoHermes,\n",
        "        codigo_quipu  = nuevoCodigoQuipu\n",
        "    WHERE id = newProjectID;\n",
        "\n",
        "    -- 3. Insertar datos de la propuesta (cotización y fechas)\n",
        "    INSERT INTO propuestas (proyecto_id, valor_cotizacion, fecha_propuesta, fecha_aprobacion)\n",
        "    VALUES (newProjectID, 90000, '2021-05-20', '2021-09-01');\n",
        "\n",
        "    -- 4. Insertar información de la ejecución (vigencia, pagos, fechas)\n",
        "    INSERT INTO ejecucion (proyecto_id, vigencia, pagos, fecha_inicio, fecha_fin)\n",
        "    VALUES (newProjectID, 2022, 3, '2022-02-01', '2022-12-01');\n",
        "\n",
        "    -- 5. Insertar datos de liquidación (fecha y observaciones)\n",
        "    INSERT INTO liquidacion (proyecto_id, fecha_liquidacion, observaciones)\n",
        "    VALUES (newProjectID, '2023-01-15', 'Liquidación finalizada exitosamente.');\n",
        "\n",
        "    -- Mensaje de confirmación\n",
        "    SELECT 'Proyecto \\\"Proyecto de Mejora Educativa\\\" insertado correctamente.' AS resultado;\n",
        "END $$\n",
        "\n",
        "DELIMITER ;"
      ],
      "metadata": {
        "id": "aJdFvAFy7VE8"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "ahora los triggers útiles\n"
      ],
      "metadata": {
        "id": "d4pJttDQAakm"
      }
    },
    {
      "cell_type": "markdown",
      "source": [
        "en la sección de abajo se incluyen algunos comandos útiles para observar distintas tablas y el estado de los datos ingresados"
      ],
      "metadata": {
        "id": "fUtllf6IQpzn"
      }
    },
    {
      "cell_type": "markdown",
      "source": [
        "1. Verificar inserción en base_maestra:"
      ],
      "metadata": {
        "id": "8gPNvhCuQ3fn"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "SELECT *\n",
        "FROM base_maestra\n",
        "WHERE objeto = 'Plataforma de Telemedicina Rural';\n"
      ],
      "metadata": {
        "id": "H2-0HAXiQxHN"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "2. Verificar inserción en propuestas:\n",
        "(Reemplaza el valor del id_cid obtenido anteriormente)"
      ],
      "metadata": {
        "id": "80qMXBA-Q4xC"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "SELECT p.*\n",
        "FROM propuestas p\n",
        "JOIN base_maestra bm ON p.id_cid = bm.id_cid\n",
        "WHERE bm.objeto = 'Plataforma de Telemedicina Rural';"
      ],
      "metadata": {
        "id": "8ZolOW50Q92_"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        "3. Verificar inserción en ejecucion:"
      ],
      "metadata": {
        "id": "Y5Dw8sceRAko"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "SELECT e.*\n",
        "FROM ejecucion e\n",
        "JOIN base_maestra bm ON e.id_cid = bm.id_cid\n",
        "WHERE bm.objeto = 'Plataforma de Telemedicina Rural';"
      ],
      "metadata": {
        "id": "sVYpnvwqRHA9"
      },
      "execution_count": null,
      "outputs": []
    },
    {
      "cell_type": "markdown",
      "source": [
        " 4. Verificar inserción en liquidacion:"
      ],
      "metadata": {
        "id": "80jOxYsxROxc"
      }
    },
    {
      "cell_type": "code",
      "source": [
        "SELECT l.*\n",
        "FROM liquidacion l\n",
        "JOIN base_maestra bm ON l.id_cid = bm.id_cid\n",
        "WHERE bm.objeto = 'Plataforma de Telemedicina Rural';"
      ],
      "metadata": {
        "id": "RifQpE1cRRZp"
      },
      "execution_count": null,
      "outputs": []
    }
  ]
}